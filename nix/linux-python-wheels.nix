{
  pkgs,
  versions,
  gpuSupport,
}:
final: prev:
let
  lib = pkgs.lib;
  platform = if pkgs.stdenv.hostPlatform.isx86_64 then "linuxX86_64" else "linuxAarch64";
  cpu = versions.cpuWheels.${platform};
  mkWheel =
    name: pin: deps: inputs:
    final.buildPythonPackage {
      pname = name;
      inherit (pin) version;
      format = "wheel";
      src = pkgs.fetchurl { inherit (pin) url hash; };
      nativeBuildInputs = [ pkgs.autoPatchelfHook ];
      buildInputs = [
        pkgs.stdenv.cc.cc.lib
        pkgs.zlib
      ]
      ++ inputs;
      propagatedBuildInputs = deps;
      preFixup = lib.optionalString (name != "torch" && name != "triton") ''
        addAutoPatchelfSearchPath "${final.torch}/${final.python.sitePackages}/torch/lib"
      '';
      dontStrip = true;
      doCheck = false;
      pythonImportsCheck = [ name ];
      meta.platforms = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
in
lib.optionalAttrs (gpuSupport == "none") {
  torch =
    (mkWheel "torch" cpu.torch (with final; [
      filelock
      typing-extensions
      setuptools
      sympy
      networkx
      jinja2
      fsspec
    ]) [ ]).overridePythonAttrs
      (_: {
        passthru = {
          inherit (pkgs) stdenv;
          cudaSupport = false;
          rocmSupport = false;
          cudaCapabilities = [ ];
          cudaPackages = { };
        };
      });
  torchvision = mkWheel "torchvision" cpu.torchvision (with final; [
    torch
    numpy
    pillow
  ]) [ final.torch ];
  torchaudio = mkWheel "torchaudio" cpu.torchaudio [ final.torch final.torchcodec ] [ final.torch ];
}
// lib.optionalAttrs (gpuSupport != "xpu") {
  triton =
    (mkWheel "triton"
      (
        {
          inherit (versions.tritonWheels) version;
        }
        // (if gpuSupport == "rocm" then versions.tritonWheels.rocm else versions.tritonWheels.${platform})
      )
      [ ]
      (
        lib.optionals (gpuSupport == "rocm") [
          pkgs.bzip2
          pkgs.xz
          pkgs.zstd
        ]
      )
    ).overridePythonAttrs
      (_: {
        autoPatchelfIgnoreMissingDeps = [
          "libcuda.so.1"
          "libamdhip64.so"
          "libamdhip64.so.7"
        ];
      });
}
// {
  # CPU media decoding also works with GPU torch; no separate GPU codec is needed.
  torchcodec =
    (mkWheel "torchcodec" (
      { inherit (versions.vendored.torchcodec) version; } // versions.vendored.torchcodec.${platform}
    ) [ final.torch final.numpy ] [ final.torch pkgs.ffmpeg pkgs.libheif ]).overridePythonAttrs
      (_: {
        # Wheels provide alternative FFmpeg backends. Only FFmpeg 9 is selected.
        autoPatchelfIgnoreMissingDeps = [
          "libavcodec.so.58"
          "libavcodec.so.59"
          "libavcodec.so.60"
          "libavcodec.so.61"
          "libavcodec.so.62"
          "libavformat.so.58"
          "libavformat.so.59"
          "libavformat.so.60"
          "libavformat.so.61"
          "libavformat.so.62"
          "libavdevice.so.58"
          "libavdevice.so.59"
          "libavdevice.so.60"
          "libavdevice.so.61"
          "libavdevice.so.62"
          "libavfilter.so.7"
          "libavfilter.so.8"
          "libavfilter.so.9"
          "libavfilter.so.10"
          "libavfilter.so.11"
          "libavutil.so.56"
          "libavutil.so.57"
          "libavutil.so.58"
          "libavutil.so.59"
          "libavutil.so.60"
          "libswresample.so.3"
          "libswresample.so.4"
          "libswresample.so.5"
          "libswresample.so.6"
          "libswscale.so.5"
          "libswscale.so.6"
          "libswscale.so.7"
          "libswscale.so.8"
          "libswscale.so.9"
        ];
      });
}
