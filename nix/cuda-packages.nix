{ pkgs, versions }:
let
  # Keep the toolkit channel aligned with the cu130 torch/vision/audio wheels.
  base = pkgs.cudaPackages_13_0;
  mkRuntime =
    name: inputs:
    let
      pin = versions.nvidiaRuntime.${name};
    in
    pkgs.stdenv.mkDerivation {
      pname = name;
      inherit (pin) version;
      src = pkgs.fetchurl { inherit (pin) url hash; };
      nativeBuildInputs = [
        pkgs.unzip
        pkgs.autoPatchelfHook
      ];
      buildInputs = [
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
        base.cuda_cudart
      ]
      ++ inputs;
      # NVSHMEM ships optional multi-node transport plugins. ComfyUI does not
      # use UCX, MPI, PMIx, libfabric, or InfiniBand transports.
      autoPatchelfIgnoreMissingDeps = [
        "libcuda.so.1"
        "libfabric.so.1"
        "libmpi.so.40"
        "libmlx5.so.1"
        "liboshmem.so.40"
        "libpmix.so.2"
        "libucp.so.0"
        "libucs.so.0"
      ];
      dontConfigure = true;
      dontBuild = true;
      dontStrip = true;
      unpackPhase = ''
        unzip -q "$src" -d wheel
      '';
      installPhase = ''
        runHook preInstall
        mkdir -p "$out/lib" "$out/include" "$out/share/licenses"
        find wheel -type f -name '*.so*' -exec cp -P {} "$out/lib/" \;
        for headers in wheel/nvidia/*/include; do
          if [ -d "$headers" ]; then cp -r "$headers"/. "$out/include/"; fi
        done
        for metadata in wheel/*.dist-info; do
          cp -r "$metadata" "$out/share/licenses/"
        done
        runHook postInstall
      '';
      meta = {
        license = pkgs.lib.licenses.unfreeRedistributable;
        platforms = [ "x86_64-linux" ];
      };
    };
in
base
// {
  # PyTorch's exact runtime requirements; nixpkgs currently has older cuDNN.
  cudnn = mkRuntime "nvidia-cudnn-cu13" [ base.libcublas ];
  nccl = mkRuntime "nvidia-nccl-cu13" [ ];
  libnvshmem = mkRuntime "nvidia-nvshmem-cu13" [ ];
}
