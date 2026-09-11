{
  nixpkgs,
  pkgs,
  source,
  packages,
  pythonRuntime,
  pythonFor,
  vendoredPackages,
  nixosModule,
}:
let
  pythonPackages = (pythonFor "none").pkgs;
  emptyExtendedPackage = packages.default.withExtraPythonPackages (_: [ ]);
  duplicateCorePackage = packages.default.withExtraPythonPackages (ps: [ ps.numpy ]);
  extendedPackage = packages.default.withExtraPythonPackages (ps: [
    ps.bcrypt
    ps.pyjwt
    ps.bleach
  ]);
  chainedPackage =
    (packages.default.withExtraPythonPackages (ps: [ ps.bcrypt ])).withExtraPythonPackages
      (ps: [
        ps.pyjwt
        ps.bleach
      ]);
  backendPackages = [
    packages.default
  ]
  ++ pkgs.lib.optional (packages ? cuda) packages.cuda
  ++ pkgs.lib.optional (packages ? rocm) packages.rocm
  ++ pkgs.lib.optional (packages ? xpu) packages.xpu;
  backendPackagesPreserved = pkgs.lib.all (
    package:
    let
      extended = package.withExtraPythonPackages (ps: [ ps.bcrypt ]);
    in
    package.pythonRuntime.pkgs.torch.outPath == extended.pythonRuntime.pkgs.torch.outPath
    && package.pythonRuntime.pkgs.numpy.outPath == extended.pythonRuntime.pkgs.numpy.outPath
  ) backendPackages;
  isNixosCheckSystem = pkgs.stdenv.hostPlatform.isLinux;
  evalModule =
    serviceConfig:
    nixpkgs.lib.nixosSystem {
      system = pkgs.stdenv.hostPlatform.system;
      modules = [
        nixosModule
        {
          system.stateVersion = "26.05";
          services.comfyui = {
            enable = true;
          }
          // serviceConfig;
        }
      ];
    };
  # Regression guard for the nixpkgs namespace clash: nixpkgs ships its own
  # nixos/modules/services/misc/comfyui.nix declaring `services.comfyui.enable`,
  # which collides with this module unless it is disabled. The stub below claims the
  # upstream module key so the conflict is reproducible against any nixpkgs revision,
  # including ones predating the upstream module.
  upstreamModuleStub =
    {
      modulesPath,
      lib,
      ...
    }:
    {
      imports = [
        {
          key = "${modulesPath}/services/misc/comfyui.nix";
          options.services.comfyui.enable = lib.mkEnableOption "ComfyUI (nixpkgs)";
        }
      ];
    };
  namespaceSystem = nixpkgs.lib.nixosSystem {
    system = pkgs.stdenv.hostPlatform.system;
    modules = [
      nixosModule
      upstreamModuleStub
      { system.stateVersion = "26.05"; }
    ];
  };
  namespaceDeclarations = namespaceSystem.options.services.comfyui.enable.declarations;
  upstreamModuleDisabled =
    pkgs.lib.length namespaceDeclarations == 1
    && pkgs.lib.hasSuffix "nix/modules/comfyui.nix" (pkgs.lib.head namespaceDeclarations);
  # Regression guard for issue #101: the module must not define `nixpkgs.overlays`
  # (or any other option `nixpkgs.nixosModules.readOnlyPkgs` marks read-only), and
  # must still resolve its package without the overlay being applied.
  readOnlyPkgsSystem = nixpkgs.lib.nixosSystem {
    modules = [
      nixpkgs.nixosModules.readOnlyPkgs
      nixosModule
      {
        nixpkgs.pkgs = pkgs;
        system.stateVersion = "26.05";
        services.comfyui.enable = true;
      }
    ];
  };
  readOnlyPkgsExecStart = readOnlyPkgsSystem.config.systemd.services.comfyui.serviceConfig.ExecStart;

  defaultModuleSystem = evalModule { };
  moduleSystem = evalModule {
    extraPythonPackages = ps: [
      ps.bcrypt
      ps.pyjwt
      ps.bleach
    ];
  };
  unsupportedPackageSystem = evalModule {
    package = packages.default.overrideAttrs (_: {
      pname = "custom-comfy-ui";
    });
    extraPythonPackages = ps: [ ps.bcrypt ];
  };
  unsupportedPackageRejected = pkgs.lib.any (
    assertion:
    !assertion.assertion && pkgs.lib.hasInfix "cannot be combined with a custom" assertion.message
  ) unsupportedPackageSystem.config.assertions;
  backendModuleSpecs = [
    {
      gpuSupport = "none";
      package = packages.default;
    }
  ]
  ++ pkgs.lib.optional (packages ? cuda) {
    gpuSupport = "cuda";
    package = packages.cuda;
  }
  ++ pkgs.lib.optional (packages ? rocm) {
    gpuSupport = "rocm";
    package = packages.rocm;
  }
  ++ pkgs.lib.optional (packages ? xpu) {
    gpuSupport = "xpu";
    package = packages.xpu;
  };
  backendModulesPreserved = pkgs.lib.all (
    spec:
    let
      system = evalModule {
        inherit (spec) gpuSupport;
        extraPythonPackages = ps: [ ps.bcrypt ];
      };
      expected = spec.package.withExtraPythonPackages (ps: [ ps.bcrypt ]);
      execStart = system.config.systemd.services.comfyui.serviceConfig.ExecStart;
    in
    pkgs.lib.hasPrefix expected.outPath execStart
  ) backendModuleSpecs;
  defaultModuleExecStart =
    defaultModuleSystem.config.systemd.services.comfyui.serviceConfig.ExecStart;
  moduleExecStart = moduleSystem.config.systemd.services.comfyui.serviceConfig.ExecStart;
  mkExtraPythonPackagesCheck =
    {
      name,
      package,
      expectedCudaVersion ? null,
    }:
    let
      extended = package.withExtraPythonPackages (ps: [
        ps.bcrypt
        ps.pyjwt
        ps.bleach
      ]);
      expectedCudaSuffix =
        if expectedCudaVersion == null then
          null
        else
          "cu${pkgs.lib.replaceStrings [ "." ] [ "" ] expectedCudaVersion}";
    in
    assert package.pythonRuntime.pkgs.torch.outPath == extended.pythonRuntime.pkgs.torch.outPath;
    assert package.pythonRuntime.pkgs.numpy.outPath == extended.pythonRuntime.pkgs.numpy.outPath;
    pkgs.runCommand name
      {
        nativeBuildInputs = [ extended.pythonRuntime ];
      }
      ''
        ${extended.pythonRuntime}/bin/python - <<'PY'
        import aiohttp
        import bcrypt
        import bleach
        import jwt
        import numpy
        import torch

        assert aiohttp.__version__
        assert bcrypt.__version__
        assert bleach.__version__
        assert jwt.__version__
        assert numpy.__version__
        assert torch.__version__
        ${pkgs.lib.optionalString (expectedCudaVersion != null) ''
          assert torch.__version__.endswith("+${expectedCudaSuffix}")
          assert torch.version.cuda == "${expectedCudaVersion}"
        ''}
        PY
        touch $out
      '';
  mssRuntimeDeps =
    assert !pythonPackages.mss.doInstallCheck;
    pythonPackages.mss;
  # Every backend's torch comes from a pre-built wheel whose metadata names
  # distributions nixpkgs supplies outside PyPI. Those requirements are dropped
  # from the installed metadata (or waved through with dontCheckRuntimeDeps),
  # so assert on the installed result instead of trusting the hook.
  #
  # The interpreter must come from `pythonFor <backend>`: `pythonRuntime.pkgs`
  # is the unoverridden nixpkgs package set and yields the stock CPU torch,
  # which would make every assertion below pass vacuously.
  mkTorchRuntimeDeps =
    {
      backend,
      removedRequirements,
    }:
    let
      torchPython = (pythonFor backend).withPackages (ps: [
        ps.torch
        ps.torchvision
        ps.torchaudio
        ps.triton
        ps.torchcodec
      ]);
      removedTuple = pkgs.lib.concatMapStrings (r: ''"${r}", '') removedRequirements;
    in
    pkgs.runCommand "${backend}-torch-runtime-deps"
      {
        nativeBuildInputs = [
          torchPython
        ]
        ++ pkgs.lib.optionals (backend == "none") [
          pkgs.stdenv.cc
          pkgs.openssl
        ];
      }
      ''
        export TORCHINDUCTOR_CACHE_DIR="$TMPDIR/torchinductor"
        ${torchPython}/bin/python - <<'PY'
        import importlib.metadata

        import setuptools
        import torch
        import torchvision
        import torchaudio
        import triton
        import torchcodec

        requirements = importlib.metadata.requires("torch") or []
        removed_requirements = (${removedTuple})

        assert not any(
            requirement.startswith(removed_requirements) for requirement in requirements
        )
        assert setuptools.__version__
        assert torch.__version__
        assert "${expectedTorchVersions.${backend}}" in torch.__version__, torch.__version__
        assert torch.__version__.split("+")[0] == "${(pythonFor backend).pkgs.torch.version}"
        assert torchvision.__version__.split("+")[0] == "${(pythonFor backend).pkgs.torchvision.version}"
        assert torchaudio.__version__.split("+")[0] == "${(pythonFor backend).pkgs.torchaudio.version}"
        assert triton.__version__ == "${(pythonFor backend).pkgs.triton.version}"

        # Exercise native vision operators and the TorchCodec audio I/O path.
        boxes = torch.tensor([[0., 0., 2., 2.], [0., 0., 2., 2.]])
        assert torchvision.ops.nms(boxes, torch.tensor([0.9, 0.8]), 0.5).tolist() == [0]
        samples = torch.linspace(-0.5, 0.5, 800).reshape(1, -1)
        torchaudio.save("roundtrip.wav", samples, 8000)
        decoded, rate = torchaudio.load("roundtrip.wav")
        assert rate == 8000 and decoded.shape == samples.shape
        torch.testing.assert_close(decoded, samples, atol=1e-4, rtol=0)
        ${pkgs.lib.optionalString (backend == "none") ''
          compiled = torch.compile(lambda x: x.sin() + x.square(), fullgraph=True)
          torch.testing.assert_close(compiled(samples), samples.sin() + samples.square())
        ''}
        PY
        touch $out
      '';
  # Guards against the check silently falling back to nixpkgs' CPU torch again.
  expectedTorchVersions = {
    none = "+cpu";
    cuda = "+cu";
    rocm = "+rocm";
    xpu = "+xpu";
  };
  torchRuntimeDepsChecks =
    pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      cpu-torch-runtime-deps = mkTorchRuntimeDeps {
        backend = "none";
        removedRequirements = [
          "nvidia-"
          "cuda-toolkit"
        ];
      };
    }
    // pkgs.lib.optionalAttrs (packages ? cuda) {
      cuda-torch-runtime-deps = mkTorchRuntimeDeps {
        backend = "cuda";
        removedRequirements = [
          "cuda-toolkit"
          "nvidia-"
        ];
      };
    }
    // pkgs.lib.optionalAttrs (packages ? rocm) {
      rocm-torch-runtime-deps = mkTorchRuntimeDeps {
        backend = "rocm";
        removedRequirements = [ "triton-rocm" ];
      };
    }
    // pkgs.lib.optionalAttrs (packages ? xpu) {
      # The XPU runtime requirements are represented by Nix packages and
      # removed from torch's installed wheel metadata.
      xpu-torch-runtime-deps = mkTorchRuntimeDeps {
        backend = "xpu";
        removedRequirements = [
          "dpcpp-"
          "impi-"
          "intel-"
          "mkl"
          "oneccl"
          "onemkl-"
          "tbb"
          "tcmlib"
          "triton"
          "umf"
        ];
      };
    };
  # Wheel packages only. The torch checks stay out of this aggregate so a
  # single CI job never has to realize three multi-gigabyte GPU closures.
  runtimeDepsPackages = {
    facexlib = pythonPackages.facexlib;
    manager = vendoredPackages.comfyuiManager;
    mss = mssRuntimeDeps;
  };
  runtimeDepsChecks = pkgs.lib.mapAttrs' (
    name: package: pkgs.lib.nameValuePair "${name}-runtime-deps" package
  ) runtimeDepsPackages;
in
{
  package = packages.default;
  python-runtime-deps = pkgs.linkFarm "python-runtime-deps" (
    pkgs.lib.mapAttrsToList (name: path: { inherit name path; }) runtimeDepsPackages
  );
}
// runtimeDepsChecks
// torchRuntimeDepsChecks
//
  pkgs.lib.optionalAttrs
    (
      pkgs.stdenv.hostPlatform.isDarwin
      || (pkgs.stdenv.hostPlatform.isLinux && pkgs.stdenv.hostPlatform.isx86_64)
    )
    {
      comfy-extras-imports =
        pkgs.runCommand "comfy-extras-imports"
          {
            nativeBuildInputs = [ pythonRuntime ];
          }
          ''
            test -f ${packages.default.customNodes.rgthree-comfy}/web/comfyui/label.js
            grep -q 'name: "rgthree.Label"' \
              ${packages.default.customNodes.rgthree-comfy}/web/comfyui/label.js

            PYTHONPATH=${packages.default.comfyuiSrc} ${pythonRuntime}/bin/python - <<'PY'
            import importlib.util
            import sys

            import kornia
            import kornia_rs
            import comfy_extras.nodes_post_processing
            import comfy_extras.nodes_latent
            import comfy_extras.nodes_canny
            import comfy_extras.nodes_morphology

            assert kornia.__version__
            assert kornia_rs.__file__

            ltxvideo_path = "${packages.default.customNodes.ltxvideo}"
            spec = importlib.util.spec_from_file_location(
                "comfyui_ltxvideo",
                f"{ltxvideo_path}/__init__.py",
                submodule_search_locations=[ltxvideo_path],
            )
            assert spec and spec.loader
            module = importlib.util.module_from_spec(spec)
            sys.modules[spec.name] = module
            spec.loader.exec_module(module)
            assert module.NODE_CLASS_MAPPINGS
            PY
            touch $out
          '';
    }
# XPU build-only check (Linux x86_64 only).
# The project maintainer has no Intel GPU, so runtime testing relies on external
# contributors. This check at least verifies the wheel patching and closure build
# succeed, catching the most common regression class (missing runtime libs,
# broken overlay, upstream wheel metadata changes).
// pkgs.lib.optionalAttrs (packages ? xpu) {
  package-xpu = packages.xpu;
}
// pkgs.lib.optionalAttrs (packages ? cuda) {
  extra-python-packages-cuda = mkExtraPythonPackagesCheck {
    name = "extra-python-packages-cuda";
    package = packages.cuda;
    expectedCudaVersion = "13.0";
  };
}
// pkgs.lib.optionalAttrs (packages ? rocm) {
  extra-python-packages-rocm = mkExtraPythonPackagesCheck {
    name = "extra-python-packages-rocm";
    package = packages.rocm;
  };
}
// pkgs.lib.optionalAttrs (packages ? xpu) {
  extra-python-packages-xpu = mkExtraPythonPackagesCheck {
    name = "extra-python-packages-xpu";
    package = packages.xpu;
  };
}
// {

  extra-python-packages =
    assert emptyExtendedPackage.outPath == packages.default.outPath;
    assert emptyExtendedPackage.pythonRuntime.outPath == pythonRuntime.outPath;
    assert duplicateCorePackage.pythonRuntime.outPath == pythonRuntime.outPath;
    assert backendPackagesPreserved;
    assert !isNixosCheckSystem || pkgs.lib.hasPrefix packages.default.outPath defaultModuleExecStart;
    assert !isNixosCheckSystem || pkgs.lib.hasPrefix extendedPackage.outPath moduleExecStart;
    assert !isNixosCheckSystem || unsupportedPackageRejected;
    assert !isNixosCheckSystem || backendModulesPreserved;
    pkgs.runCommand "extra-python-packages"
      {
        nativeBuildInputs = [ chainedPackage.pythonRuntime ];
      }
      ''
        ${chainedPackage.pythonRuntime}/bin/python - <<'PY'
        import aiohttp
        import bcrypt
        import bleach
        import jwt
        import numpy
        import torch

        assert aiohttp.__version__
        assert bcrypt.__version__
        assert bleach.__version__
        assert jwt.__version__
        assert numpy.__version__
        assert torch.__version__
        PY
        touch $out
      '';

  extra-python-packages-runtime = mkExtraPythonPackagesCheck {
    name = "extra-python-packages-runtime";
    package = packages.default;
  };

  pytest =
    let
      pytestPython = pkgs.python3.withPackages (ps: [ ps.pytest ]);
    in
    pkgs.runCommand "pytest"
      {
        nativeBuildInputs = [ pytestPython ];
        src = source;
      }
      ''
        cp -r $src source
        chmod -R u+w source
        cd source
        PYTHONPATH=src/custom_nodes/model_downloader \
          ${pytestPython}/bin/pytest \
          src/custom_nodes/model_downloader/test_model_downloader.py -v
        touch $out
      '';

  ruff-check =
    pkgs.runCommand "ruff-check"
      {
        nativeBuildInputs = [ pkgs.ruff ];
        src = source;
      }
      ''
        cp -r $src source
        chmod -R u+w source
        cd source
        ${pkgs.ruff}/bin/ruff check --no-cache src/
        touch $out
      '';

  pyright-check =
    pkgs.runCommand "pyright-check"
      {
        nativeBuildInputs = [ pkgs.pyright ];
        src = source;
      }
      ''
        cp -r $src source
        chmod -R u+w source
        cd source
        ${pkgs.pyright}/bin/pyright \
          --pythonpath ${pythonRuntime}/bin/python \
          src/
        touch $out
      '';

  nixfmt =
    pkgs.runCommand "nixfmt-check"
      {
        nativeBuildInputs = [
          pkgs.nixfmt
          pkgs.findutils
        ];
        src = source;
      }
      ''
        cp -r $src source
        chmod -R u+w source
        cd source
        # Find all .nix files explicitly to avoid deprecation warning
        find . -name '*.nix' -type f -exec nixfmt --check {} +
        touch $out
      '';

  shellcheck =
    pkgs.runCommand "shellcheck"
      {
        nativeBuildInputs = [
          pkgs.shellcheck
          pkgs.findutils
        ];
        src = source;
      }
      ''
        cp -r $src source
        chmod -R u+w source
        cd source
        # Check all shell scripts in scripts/
        find scripts -name '*.sh' -type f -exec shellcheck {} +
        touch $out
      '';
}
// pkgs.lib.optionalAttrs isNixosCheckSystem {
  nixos-module-namespace =
    assert upstreamModuleDisabled;
    pkgs.runCommand "nixos-module-namespace" { } "touch $out";

  nixos-module-read-only-pkgs =
    assert pkgs.lib.hasPrefix packages.default.outPath readOnlyPkgsExecStart;
    pkgs.runCommand "nixos-module-read-only-pkgs" { } "touch $out";
}
