{
  comfyui = {
    version = "0.34.0";
    releaseDate = "2026-08-26T02:09:08Z";
    rev = "12d5279438bfefc058a269eae805ceab6047777f";
    hash = "sha256-pW02gtrtWkoPabYe6Q/gicNRM65JRYsc7vtaY1m6H1M=";
  };

  vendored = {
    av = {
      version = "18.1.0";
      linuxX86_64 = {
        url = "https://files.pythonhosted.org/packages/27/3a/204dbfc3e08eb4cdc6e6ff57be02150bc44523ebdb50182d10025792ebd9/av-18.1.0-cp311-abi3-manylinux_2_28_x86_64.whl";
        hash = "sha256-igMujY68c97AeTZLm0poN2OKLRBuhHIxTmhf+/Fj5wA=";
      };
      linuxAarch64 = {
        url = "https://files.pythonhosted.org/packages/d9/84/2464ffb64c08c5ce8b522c8e74594714414e3b0575267652c5c51c0574b9/av-18.1.0-cp311-abi3-manylinux_2_28_aarch64.whl";
        hash = "sha256-b8g3zFGt+AMxrIUHec1TtdTERgsOvpBXoCqSHGc28Z0=";
      };
      darwinArm64 = {
        url = "https://files.pythonhosted.org/packages/3f/c9/37a619297492256b77d5ed906e7d8166c10a26ed251dccf1ae03ab19bff6/av-18.1.0-cp311-abi3-macosx_14_0_arm64.whl";
        hash = "sha256-swpOjZNFWOGWAraJmKTZrJ8lD6DazvIW9+jkAVOxMxY=";
      };
    };
    torchcodec = {
      version = "0.16.0";
      linuxAarch64 = {
        url = "https://download.pytorch.org/whl/cpu/torchcodec-0.16.0%2Bcpu-cp312-cp312-manylinux_2_27_aarch64.manylinux_2_28_aarch64.whl";
        hash = "sha256-LbFjrQFTO2UxxgaoPQAuZxbimErHdaH8BzAOWevNpGk=";
      };
      linuxX86_64 = {
        url = "https://download.pytorch.org/whl/cpu/torchcodec-0.16.0%2Bcpu-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl";
        hash = "sha256-sQFOpDepXYVlsTpW1gTVKXs47fS2tywnkSaokLOiHvw=";
      };
    };

    spandrel = {
      version = "0.4.2";
      url = "https://files.pythonhosted.org/packages/74/31/411ea965835534c43d4b98d451968354876e0e867ea1fd42669e4cca0732/spandrel-0.4.2-py3-none-any.whl";
      hash = "sha256-bJPj7L6w5Uj9LfRaYFRys0wWFCh8VrUbszze965SNbU=";
    };

    frontendPackage = {
      version = "1.52.7";
      url = "https://files.pythonhosted.org/packages/a8/1e/835f8b0396645a28266a87eeda6392f461a2ef87391cbf729ef9a7ae5d75/comfyui_frontend_package-1.52.7-py3-none-any.whl";
      hash = "sha256-OqViT6UIX4Rh0xt+uIpC7Wmg54OjW+wcKjO5D8dmCVA=";
    };

    workflowTemplates = {
      version = "0.11.57";
      url = "https://files.pythonhosted.org/packages/1e/df/12106a07f991d05f23d9d87000c9515f3b94b2a106d0f5c013d6d501c92c/comfyui_workflow_templates-0.11.57-py3-none-any.whl";
      hash = "sha256-Uem7MHKU2jiB8SapGxITMOD4ziDur8sqf2NPFGciBrU=";
    };

    workflowTemplatesCore = {
      version = "0.3.337";
      url = "https://files.pythonhosted.org/packages/7a/24/489449c3a289411c7fa02af6479675e6621af66ee6dc824107d9eb3e103b/comfyui_workflow_templates_core-0.3.337-py3-none-any.whl";
      hash = "sha256-wBWIjhGjgMwCpxidShk9vzxL8I40khpHRkSysfzO9V8=";
    };

    workflowTemplatesJson = {
      version = "0.1.72";
      url = "https://files.pythonhosted.org/packages/dc/b5/6f6b4a83f9e5ebdfa0b9c1ef77d0064396678724867837afbf9d7a310d61/comfyui_workflow_templates_json-0.1.72-py3-none-any.whl";
      hash = "sha256-HT/q61C//0Fk2bGauyITHMzOiAVaqT/UzOoZkYKZ884=";
    };

    workflowTemplatesMediaApi = {
      version = "0.3.84";
      url = "https://files.pythonhosted.org/packages/35/47/e4c723615b396f75893049af38a4b53bcb0e8944418819bb0e0d72f342e8/comfyui_workflow_templates_media_api-0.3.84-py3-none-any.whl";
      hash = "sha256-wtalmZrDnk839HriMcklV97+Wt2yzGq1wRQQtNWikQo=";
    };

    workflowTemplatesMediaVideo = {
      version = "0.3.101";
      url = "https://files.pythonhosted.org/packages/e5/9e/49e1fbe9f05df7e4410a8d485af2a2d6fe80b247d44b3bfa7166c54012ef/comfyui_workflow_templates_media_video-0.3.101-py3-none-any.whl";
      hash = "sha256-YnD9YcjDkxtvADGrrH1MkM7WJN5seRi/+FuJ5sPXSTw=";
    };

    workflowTemplatesMediaImage = {
      version = "0.3.160";
      url = "https://files.pythonhosted.org/packages/bd/2e/aa57dc75cc2a73921d8472a398678e1ac40c011756ad0ab2dfe41eb0ba15/comfyui_workflow_templates_media_image-0.3.160-py3-none-any.whl";
      hash = "sha256-1KXFVBxwiPatscfaQfXXwcFKA37aamHNi0t2wlH6qpM=";
    };

    workflowTemplatesMediaOther = {
      version = "0.3.229";
      url = "https://files.pythonhosted.org/packages/a7/46/feed5492a2def46fee71a52fcbb3b7443a048e402c40bedfaaebcc6fa234/comfyui_workflow_templates_media_other-0.3.229-py3-none-any.whl";
      hash = "sha256-zj2Y+p2EuRTDNf5cm8kDz+++GTKxvDy2uu9/NxtL1DU=";
    };

    workflowTemplatesMediaAssets01 = {
      version = "0.1.43";
      url = "https://files.pythonhosted.org/packages/77/3c/a21845eb72790e92db4eea71724bdc41e2b0f29382f02de3412e671d9b8f/comfyui_workflow_templates_media_assets_01-0.1.43-py3-none-any.whl";
      hash = "sha256-bIaPeOqgXW3Kh2H7G3jDv0Zgq/x03du9/7QfTgaagU0=";
    };

    embeddedDocs = {
      version = "0.5.11";
      url = "https://files.pythonhosted.org/packages/63/0f/f30966d7610571f0c1cb1034d4489b91db8afc5399fc1a4d0b8520689f6f/comfyui_embedded_docs-0.5.11-py3-none-any.whl";
      hash = "sha256-CrPpYlNnbQXK+E1ge4FcQyceUDAvPFHONjyuVHmqaX8=";
    };

    manager = {
      version = "4.2.2";
      url = "https://files.pythonhosted.org/packages/2c/21/ff7464c4ea1bc53741280d2b26046c2c9e8ba742e096a971aff2f83da1bb/comfyui_manager-4.2.2-py3-none-any.whl";
      hash = "sha256-mwMx5bhEg7QGJgSAuSrZHb2Ec8rm4iYhJ+jBFXfOBHM=";
    };

    # New ComfyUI core deps (not in nixpkgs).
    # comfy-kitchen and comfy-aimdo ship platform wheels with native libraries
    # (kitchen: backends/cuda/_C.abi3.so, aimdo: aimdo.so/aimdo_rocm.so). The
    # py3-none-any wheels are pure-Python and silently disable those features
    # (issue #66), so prefer the platform wheels where they exist and keep the
    # any-wheel as the macOS fallback.
    comfyKitchen = {
      version = "0.2.33";
      any = {
        url = "https://files.pythonhosted.org/packages/ed/af/7effaeade6a7edfd73440971b71b014cb940e967b564ce488852a22176d8/comfy_kitchen-0.2.33-py3-none-any.whl";
        hash = "sha256-16/g53LX+1O825WOLN40fR2TVmGTeAxsM37FFAPSugQ=";
      };
      linuxAarch64 = {
        url = "https://files.pythonhosted.org/packages/72/90/bfbfceb2ea1efd8f9ca6ad1473bffbc2fb50872bb7cfe8611a8541d8f1b3/comfy_kitchen-0.2.33-cp312-abi3-manylinux_2_26_aarch64.manylinux_2_28_aarch64.whl";
        hash = "sha256-X5YuL0vT4AK5GIemFI0aB9BwiQwdKJFHXBrlnBwD9Sc=";
      };
      linuxX86_64 = {
        url = "https://files.pythonhosted.org/packages/5f/e1/324966117ea9254ece8dbba0e970a92ec8a33535cbf289a6326d386fdf31/comfy_kitchen-0.2.33-cp312-abi3-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl";
        hash = "sha256-FWMGgU80TzsAQWSoY7aH0BKPPAZx5Dwk8gRbHVW+Uw8=";
      };
    };

    # ANGLE libraries for the GLSL shader nodes (comfy_extras/nodes_glsl.py).
    # Replaces glfw as of ComfyUI v0.28. Platform-specific wheels containing
    # native libEGL/libGLESv2.
    comfyAngle = {
      version = "0.1.1";
      linuxX86_64 = {
        url = "https://files.pythonhosted.org/packages/af/f4/5ddd0416e9619233b20e2a34c47d2359d4ac6b17a17f8bf59e0bfe5b93c3/comfy_angle-0.1.1-py3-none-manylinux_2_28_x86_64.whl";
        hash = "sha256-PS/KuThuu7VlPWZpb6i8rTKcHRhS6kth8obqmUhahAo=";
      };
      linuxAarch64 = {
        url = "https://files.pythonhosted.org/packages/48/be/a4df53ed0cd450b3f892b4f746a048b3b2bd9b1eb97816538ea69c06abd1/comfy_angle-0.1.1-py3-none-manylinux_2_28_aarch64.whl";
        hash = "sha256-ZrfIkJ+YMnk1cDfvD2mU+n4wOkHYp3oKB1pjek6z/m4=";
      };
      darwinArm64 = {
        url = "https://files.pythonhosted.org/packages/9f/0d/44c35dbe55cacd4b7683d83ab00aacc2c136268e2545a425a8af4c2c8b0e/comfy_angle-0.1.1-py3-none-macosx_11_0_arm64.whl";
        hash = "sha256-wK8X4XBwz3r129ZsUaG2zKKCDIYR5IfnvTmABqFEcSQ=";
      };
    };

    comfyAimdo = {
      version = "0.5.3";
      any = {
        url = "https://files.pythonhosted.org/packages/e4/ef/9a94b88981e51dea163f2fdf98cd28424276fab6a31dc7e22ce89018778f/comfy_aimdo-0.5.3-py3-none-any.whl";
        hash = "sha256-sJQBRDnUGocFEDEjyXtOoqT4WE+uIMsUuVNLa4Ky6Xw=";
      };
      linuxAarch64 = {
        url = "https://files.pythonhosted.org/packages/96/5a/f38fd0c29a75daf40e62ee7b78b4889a622f12666e7e87e847eab7b8979f/comfy_aimdo-0.5.3-cp39-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl";
        hash = "sha256-2Hd2y+Wem8itKApgsQjUvSukCvQIui5fXAStQBzzVXE=";
      };
      linuxX86_64 = {
        url = "https://files.pythonhosted.org/packages/1a/bc/aa38d79aed78aee21d1186e056f8b8e348c6af78874d6f7ed257a6dddf5d/comfy_aimdo-0.5.3-cp39-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl";
        hash = "sha256-Xdx+EqISDT514x9t/1JEjdC9MFgnfxD3ky6Zwg0Xrno=";
      };
    };

    # Optional attention optimization (used by --use-sage-attention)
    sageattention = {
      version = "1.0.6";
      url = "https://files.pythonhosted.org/packages/53/06/f7b47adb766bcb38b3f88763374a3e8dffea05ee9b556bc24dbcbd60fd29/sageattention-1.0.6-py3-none-any.whl";
      hash = "sha256-+vxmVpvtYqFoOeggwmEhQbWiCsz1W4dtlBurnArF2Ig=";
    };

    # Python packages not in nixpkgs (vendored for custom nodes)
    segment-anything = {
      version = "1.0";
      rev = "dca509fe793f601edb92606367a655c15ac00fdf";
      hash = "sha256-28XHhv/hffVIpbxJKU8wfPvDB63l93Z6r9j1vBOz/P0=";
    };

    sam2 = {
      version = "1.0";
      rev = "2b90b9f5ceec907a1c18123530e92e794ad901a4";
      hash = "sha256-pUPaUD/5wOhdJcNYPH9LV5oA1noDeWKconfpIFOyYBQ=";
    };

    color-matcher = {
      version = "0.6.0";
      url = "https://files.pythonhosted.org/packages/a0/3a/f3c2c5012f59235ff5885db7cc75dc209eca90e42ae3728db56f8a9e28a4/color_matcher-0.6.0-py3-none-any.whl";
      hash = "sha256-/WQvlBTDO38+vJb+CIjBxiAINhQmZFic4sy1LrzadzQ=";
    };

    # facexlib - face processing library needed by PuLID
    facexlib = {
      version = "0.3.0";
      url = "https://files.pythonhosted.org/packages/36/7b/2147339dafe1c4800514c9c21ee4444f8b419ce51dfc7695220a8e0069a6/facexlib-0.3.0-py3-none-any.whl";
      hash = "sha256-JF1YhhU3uCDGFuiz72GMz60qJHJKLXS+KwVCZDwBqHg=";
    };
  };

  # Pre-built PyTorch wheels from pytorch.org
  # These avoid compiling PyTorch from source (which requires 30-60GB RAM)
  # CUDA wheels bundle CUDA libraries, so no separate CUDA toolkit needed at runtime
  # macOS wheels use PyTorch 2.5.1 to avoid MPS issues on macOS 26 (Tahoe)
  cpuWheels = {
    linuxX86_64 = {
      torch = {
        version = "2.14.0";
        url = "https://download.pytorch.org/whl/cpu/torch-2.14.0%2Bcpu-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-oJmHyV7Ez/2233mNPWQVWBEKM0z8zOIvLwRtgxQrwmA=";
      };
      torchvision = {
        version = "0.29.0";
        url = "https://download.pytorch.org/whl/cpu/torchvision-0.29.0%2Bcpu-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-prq5HEDUaaZW02G47GDr39hsUVrUeyzVA30X2zBBTXU=";
      };
      torchaudio = {
        version = "2.11.0";
        url = "https://download.pytorch.org/whl/cpu/torchaudio-2.11.0%2Bcpu-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-I1QkiEjQaprh56EhZfgA8N2n32DsrJ/KiSMityK5IsA=";
      };
    };
    linuxAarch64 = {
      torch = {
        version = "2.14.0";
        url = "https://download.pytorch.org/whl/cpu/torch-2.14.0%2Bcpu-cp312-cp312-manylinux_2_28_aarch64.whl";
        hash = "sha256-2oFAw9SkFQDSlxDjW/jmakKV7DECZIfGn1Sj9YMxD40=";
      };
      torchvision = {
        version = "0.29.0";
        url = "https://download.pytorch.org/whl/cpu/torchvision-0.29.0%2Bcpu-cp312-cp312-manylinux_2_28_aarch64.whl";
        hash = "sha256-isCW/nlt+svRdL6G96s1laOeq8NB0u4uSFVwMuwdV8Q=";
      };
      torchaudio = {
        version = "2.11.0";
        url = "https://download.pytorch.org/whl/cpu/torchaudio-2.11.0%2Bcpu-cp312-cp312-manylinux_2_28_aarch64.whl";
        hash = "sha256-ud0sasFEAB3G2sOLVkwd5zrCbvDBldUDfEqUmQsOK1o=";
      };
    };
  };

  tritonWheels = {
    version = "3.8.0";
    linuxX86_64 = {
      url = "https://files.pythonhosted.org/packages/c1/09/b7012e5bfae67640f268aa584caa80fe1674f6b0da949046b679972c33e3/triton-3.8.0-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl";
      hash = "sha256-6R/6RtCVslIkgpcpLdIry6zVOhJaDC7vu790kloyC8M=";
    };
    linuxAarch64 = {
      url = "https://files.pythonhosted.org/packages/87/07/0f8cd8e8db0472334253efdaaab3d0819fea27aa99bf0e7f1aeea4ceb5ae/triton-3.8.0-cp312-cp312-manylinux_2_27_aarch64.manylinux_2_28_aarch64.whl";
      hash = "sha256-qcQExp7Uo56OxjLq9rn+BYoGC/mJecF39u9mbwa7jVA=";
    };
    rocm = {
      url = "https://download.pytorch.org/whl/triton_rocm-3.8.0-cp312-cp312-linux_x86_64.whl";
      hash = "sha256-Yxjm+qITlWMt76E8V/qE/OXEKnnFMRWZEfIn5ZlCLro=";
    };
  };

  nvidiaRuntime = {
    nvidia-cudnn-cu13 = {
      version = "9.24.0.43";
      url = "https://files.pythonhosted.org/packages/5c/ba/791cffd048fe5b044e620df55267e3e95c0e6e07d50b41e377c03dfc910f/nvidia_cudnn_cu13-9.24.0.43-py3-none-manylinux_2_27_x86_64.whl";
      hash = "sha256-cfGBzYEOkPm2AjsBGG/oLRPWXw7AmFge4gHTn612nks=";
    };
    nvidia-nccl-cu13 = {
      version = "2.30.7";
      url = "https://files.pythonhosted.org/packages/3f/34/c500f90c7ae641b8e0f98965b36b8a7ac79cc8b296e8d251fe3eb592ee54/nvidia_nccl_cu13-2.30.7-py3-none-manylinux_2_18_x86_64.whl";
      hash = "sha256-zvp/25cQ79DznF8b4dYf9vyamWxFEmW9f73PlFXtS1A=";
    };
    nvidia-nvshmem-cu13 = {
      version = "3.4.5";
      url = "https://files.pythonhosted.org/packages/3c/35/a9bf80a609e74e3b000fef598933235c908fcefcef9026042b8e6dfde2a9/nvidia_nvshmem_cu13-3.4.5-py3-none-manylinux2014_x86_64.manylinux_2_17_x86_64.whl";
      hash = "sha256-KQ8KLulMnzaHoCUC87kpmp+f6Cbm0Ch+4YSC541JW4A=";
    };
  };

  pytorchWheels = {
    # macOS Apple Silicon (arm64) - PyTorch 2.5.1 (2.9.x has MPS bugs on macOS 26)
    darwinArm64 = {
      torch = {
        version = "2.5.1";
        url = "https://download.pytorch.org/whl/cpu/torch-2.5.1-cp312-none-macosx_11_0_arm64.whl";
        hash = "sha256-jHEt9hEBlk6xGRCoRlFAEfC29ZIMVdv1Z7/4o0Fj1bE=";
      };
      torchvision = {
        version = "0.20.1";
        url = "https://download.pytorch.org/whl/cpu/torchvision-0.20.1-cp312-cp312-macosx_11_0_arm64.whl";
        hash = "sha256-GjElb/lF1k8Aa7MGgTp8laUx/ha/slNcg33UwQRTPXo=";
      };
      torchaudio = {
        version = "2.5.1";
        url = "https://download.pytorch.org/whl/cpu/torchaudio-2.5.1-cp312-cp312-macosx_11_0_arm64.whl";
        hash = "sha256-8cv9/Ru9++conUenTzb/bF2HwyBWBiAv71p/tpP2HPA=";
      };
    };
    # Linux x86_64 CUDA 13.0
    cu130 = {
      torch = {
        version = "2.14.0";
        url = "https://download.pytorch.org/whl/cu130/torch-2.14.0%2Bcu130-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-nFaT08qRdDICA0CUrTs98gtesTc9XgvIpdl2vhLDUwI=";
      };
      torchvision = {
        version = "0.29.0";
        url = "https://download.pytorch.org/whl/cu130/torchvision-0.29.0%2Bcu130-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-+2gaNnvs2/QM1VnxtVO+eYMohaWEFJgOd77Rkv2WBnM=";
      };
      torchaudio = {
        version = "2.11.0";
        url = "https://download.pytorch.org/whl/cu130/torchaudio-2.11.0%2Bcu130-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-P7qYj0MB/hNUf+XpnHbZrjaifhne2C7v/tnSRW4S7e8=";
      };
    };
    # Linux x86_64 ROCm 7.2
    rocm72 = {
      torch = {
        version = "2.14.0";
        url = "https://download.pytorch.org/whl/rocm7.2/torch-2.14.0%2Brocm7.2-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-1ntC4xKEiU0kwnv8P9eH+/wL7x6mvZBtt8+n1T0f/oQ=";
      };
      torchvision = {
        version = "0.29.0";
        url = "https://download.pytorch.org/whl/rocm7.2/torchvision-0.29.0%2Brocm7.2-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-H3QGKfWrsp/dtmFTxEQ4lFriLsKnqbiIJuAgtzbJCyE=";
      };
      torchaudio = {
        version = "2.11.0";
        url = "https://download.pytorch.org/whl/rocm7.2/torchaudio-2.11.0%2Brocm7.2-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-4DFtk4NGz6T/BLkUBakezFC9GHgQI+yldjt58Pe5vIw=";
      };
    };
    # Linux x86_64 Intel XPU (oneAPI / SYCL)
    # In-tree PyTorch XPU — no IPEX needed. Targets Arc A/B series and
    # Core Ultra (Meteor Lake+) iGPUs. Older Xe-LP iGPUs (UHD 770) are
    # not officially supported by Intel/PyTorch — untested here.
    #
    # The XPU torch wheel does NOT bundle its Intel runtime libs the way CUDA
    # and ROCm wheels do. Instead it declares ~20 Intel runtime wheel deps in
    # Requires-Dist. All are pinned in `xpuRuntime` below and wired up as
    # propagatedBuildInputs of torch in python-overrides.nix.
    xpu = {
      torch = {
        version = "2.14.0";
        url = "https://download.pytorch.org/whl/xpu/torch-2.14.0%2Bxpu-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-BfjxMOJcJNT3kDJmrxZRRekjT66M5z7CYTrfwBXLo0o=";
      };
      torchvision = {
        version = "0.29.0";
        url = "https://download.pytorch.org/whl/xpu/torchvision-0.29.0%2Bxpu-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-582JITCsz2pFaZhPOCHU4DzudeBQMsS9YhS+5kImcZ8=";
      };
      torchaudio = {
        version = "2.11.0";
        url = "https://download.pytorch.org/whl/xpu/torchaudio-2.11.0%2Bxpu-cp312-cp312-manylinux_2_28_x86_64.whl";
        hash = "sha256-VE99BDqIzK6mzzTUP5FFoPYLFOkWPAIYQduiaQaciHk=";
      };
    };
  };

  # Intel XPU runtime wheel pins (declared as Requires-Dist by torch-2.14.0+xpu).
  # These are PyPI-hosted wheels from Intel except triton-xpu which lives on
  # download.pytorch.org. All are py2.py3-none-manylinux_2_28_x86_64 binary
  # distributions containing .so files and Python shims.
  xpuRuntime = {
    intel-cmplr-lib-rt = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/5b/f4/c59236000ce3a470bfcae4053ad96e97c3c9febf2b38e5487046b7f4505f/intel_cmplr_lib_rt-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-jgAqr4l0HeO0JL2tUc5g6tIcyPTe6XD8y6iO48hFaS0=";
    };
    intel-cmplr-lib-ur = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/8e/06/da0fcd62ee4672489ede80f322eec61b48a38695b0a5072d6d1075b37197/intel_cmplr_lib_ur-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-dLZKzoJ3sDGqNjKNyPh/f5WabKTaW2jGmSPTcoPgFmQ=";
    };
    intel-cmplr-lic-rt = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/2a/9c/cfdfb3429b32fbd2bed7a9bcce2989efa329ca1b87b70e03bc9170650512/intel_cmplr_lic_rt-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-7J98SVvaj10mBEIFaAjudc9MGhRZEM6Zng6JZNeM4bo=";
    };
    intel-sycl-rt = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/5b/9d/b183c4bdc59921b0e15006fb301b278d998abd5dc803051478de32da3476/intel_sycl_rt-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-yPSueHwzTWpItmUUsqwpx7tK7d4pOci6Yec3DKdI/OY=";
    };
    oneccl-devel = {
      version = "2022.1.1";
      url = "https://files.pythonhosted.org/packages/d5/c1/a62b38dec8add789fae282fcdaaebbb1bf55db32922fcd2fb42f8523cdc1/oneccl_devel-2022.1.1-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-oIi6Z6NhC9tiG4IzWVPOtL2mW4EUajBqG7PGTkfUdzU=";
    };
    oneccl = {
      version = "2022.1.1";
      url = "https://files.pythonhosted.org/packages/1c/c0/54bf02d28010584627de21af467ee34026e231528e5141069080805076d4/oneccl-2022.1.1-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-6HetNyDo1t1F1xzwXdnWXmb1o4wJAAifFUJWnkNRLng=";
    };
    impi-rt = {
      version = "2021.18.1";
      url = "https://files.pythonhosted.org/packages/0e/88/a4f4392dcf96a33e53348584f0935f800292e96d093da298fcb8088ae9dd/impi_rt-2021.18.1-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-UcqJweZOYNhqfUCn1hJDErpjqvwD+2qswUCzxmNx2BQ=";
    };
    onemkl-license = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/e3/ef/8437c187319e779a76f4dbb468a1863d729297d79a1b5f44b10a58c96ec2/onemkl_license-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-Of2ClkivksngPCK6Io8HF02Cmqov48X2zXBzuOuKmAU=";
    };
    onemkl-sycl-blas = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/d6/c5/94ce322721013c42578398846e57da4273d1f8e48ab1e49ad311a418d36e/onemkl_sycl_blas-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-Ip3RlGK0pYjBVupzvOKf6vDpZDTXl6m644qJaU/EZJM=";
    };
    onemkl-sycl-dft = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/71/60/80d4fa8e4e100f290572cf99856e067195fb9d22a7f462b8e0993833c526/onemkl_sycl_dft-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-cb00+MJbaGmkQKAerdJ0MVFgG/LQEbAcESBuyB9t6As=";
    };
    onemkl-sycl-lapack = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/0c/ee/9058fe036b82bc742adb6280574502da2a8c70364a945829579fd3dd8084/onemkl_sycl_lapack-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-l/82JvmUY+UHNKhQNO0sp2VgG1xdOwVgaV2nrsC09ik=";
    };
    onemkl-sycl-rng = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/f0/3c/4ee5d31e04539d1acd0a1acd3ddf722db570ac8c381d5bc2a9a197e31ca7/onemkl_sycl_rng-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-bSTuedotf+OLmd/fPDbjny3Hlr4KtcR3o+bRwkTtXM0=";
    };
    onemkl-sycl-sparse = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/83/af/416bc19b3488129975a9bd1dbdb8bbe9340a49a802c1e24db6728e233359/onemkl_sycl_sparse-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-UOb+LNkBCQ1HP8VyABz6XA0ABxkDZ0XjpMlep0sy+cw=";
    };
    dpcpp-cpp-rt = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/7e/98/20fffd109174139f7dc5a3413ffca0d71e0ea0837b5d7b62b634aa44ad3d/dpcpp_cpp_rt-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-nnBY3t8YycyOW6/1ltxs8MUygH86WTS2DpW+L2nuQBQ=";
    };
    intel-opencl-rt = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/24/ac/08bb51b090cc1dc3ab24567901610b33d5495c76194e6714e26a2c66390a/intel_opencl_rt-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-sokbam80fyHSqfDocvuX4a70B7TDRxRRaZTdiE6l4Z4=";
    };
    mkl = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/61/da/4921e17b1f455f7fed30d5cc0964f3289eee6a6cb03cdf7d5e20c14bd025/mkl-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-TVomRJgYqK69SyqvaykYMeaR+c90sVLfSbmc9Iu9U2A=";
    };
    intel-openmp = {
      version = "2026.1.0";
      url = "https://files.pythonhosted.org/packages/72/23/60aeb428e6b1fb34fb81d4970d91ff8b5deeeeb446e1628bd78f9e3d1f8b/intel_openmp-2026.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-5oh/cBt9IyPtFHAIiTua8i5RGqqX4PycN+uL4kpTZrA=";
    };
    tbb = {
      version = "2023.1.0";
      url = "https://files.pythonhosted.org/packages/25/0c/0266c71e3fa50a71db5ce8a1d0807863df3215c5f7b5fe7c98b257561138/tbb-2023.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-ZK01JBxzallUmPU0Or7I6qogPp/g29v0uG03xaOrHZw=";
    };
    tcmlib = {
      version = "1.5.0";
      url = "https://files.pythonhosted.org/packages/60/24/aa409bb20703acc70cf4d3bc620a55c789639c2995b2667fb44ae7236ec9/tcmlib-1.5.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-nXwBz/Narpv1OQtiBoDr3xCn0hHCLWSIonoClQLn0Ko=";
    };
    umf = {
      version = "1.1.0";
      url = "https://files.pythonhosted.org/packages/c4/72/2e0182f4e6a727a15d0a8a99a82182a4f5bdec1a4f5767acfd2abdc72070/umf-1.1.0-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-VnFSxe5rjhbMVrKaipprkY3h/r+Jh39x6i6CR+85/DI=";
    };
    intel-pti = {
      version = "1.0.1";
      url = "https://files.pythonhosted.org/packages/46/d4/48737239235707852fef380005f53405740b08dc5f3700c72e5b43946452/intel_pti-1.0.1-py2.py3-none-manylinux_2_28_x86_64.whl";
      hash = "sha256-TnrZ6VXS2tjkHNldIuirHkdrri5uNR8Oi0ZT/nerLgw=";
    };
    pyzes = {
      version = "0.1.2";
      url = "https://files.pythonhosted.org/packages/74/46/90e1741b3926e3b8590dfaa819439891865568fc5c90a0f5596b76ee6bff/pyzes-0.1.2-py3-none-any.whl";
      hash = "sha256-VjhoQ5kEmUBBQHGvr/+R7ofxiAdFezyw0xzV1aC32yM=";
    };
    triton-xpu = {
      version = "3.8.0";
      url = "https://download.pytorch.org/whl/triton_xpu-3.8.0-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl";
      hash = "sha256-sZ9HcmdWtHLsdEYQ4wztEAj0kRMGqUtcpSJLcaEcIUk=";
    };
  };

  # Custom nodes with pinned versions
  customNodes = {
    impact-pack = {
      hash = "sha256-Zom2ugLAnxDhjDxIGO5jpc2oACFD7S8TUkj9rRXN3xI=";
      owner = "ltdrdata";
      repo = "ComfyUI-Impact-Pack";
      rev = "429d0159ad429e64d2b3916e6e7be9c22d025c3c";
      version = "git-2026-04-19-429d0159ad42";
    };

    rgthree-comfy = {
      hash = "sha256-Z3yKY+6VW5wfsOkI+LrNFd3oZMXKVITtinsNXVXFNec=";
      owner = "rgthree";
      repo = "rgthree-comfy";
      rev = "2c5342a8cb0eaecaabf61435a5f37dd594c510ba";
      version = "git-2026-09-01-2c5342a8cb0e";
    };

    kjnodes = {
      hash = "sha256-V9V3mSkUss+ll5V9r7W2PLwh8S+awvilnjSHRxUyv7k=";
      owner = "kijai";
      repo = "ComfyUI-KJNodes";
      rev = "57105374f47d0fbb49c9c3926fb981702e0a4b5c";
      version = "git-2026-09-08-57105374f47d";
    };

    gguf = {
      version = "git-2026-02-04-6ea2651e7df6";
      owner = "city96";
      repo = "ComfyUI-GGUF";
      rev = "6ea2651e7df66d7585f6ffee804b20e92fb38b8a";
      hash = "sha256-/ZwecgxTTMo9J1whdEJci8lEkOy/yP+UmjbpOAA3BvU=";
    };

    ltxvideo = {
      hash = "sha256-gIe9PgtRS+B7L3DR0stH1VTUhRxOSMf5W7THB/kGHsw=";
      owner = "Lightricks";
      repo = "ComfyUI-LTXVideo";
      rev = "15d09abb5a187a8dcaea2fc31fe51ee96e6c9d0d";
      version = "git-2026-08-20-15d09abb5a18";
    };

    florence2 = {
      hash = "sha256-TlAntRh6US5IkLzY32K5qTpr8KMQQmEQzUeExAHgDJA=";
      owner = "kijai";
      repo = "ComfyUI-Florence2";
      rev = "9ece3de914214c5f581d725167bc9d0eeb0d1120";
      version = "git-2026-05-06-9ece3de91421";
    };

    bitsandbytes-nf4 = {
      version = "2024-08-15";
      owner = "comfyanonymous";
      repo = "ComfyUI_bitsandbytes_NF4";
      rev = "6c65152bc48b28fc44cec3aa44035a8eba400eb9";
      hash = "sha256-akwKtwW3uDOe/anox5B/WT7Fx2n+7hP0elaYO2cyJFk=";
    };

    x-flux = {
      version = "2024-10-30";
      owner = "XLabs-AI";
      repo = "x-flux-comfyui";
      rev = "00328556efc9472410d903639dc9e68a8471f7ac";
      hash = "sha256-9487Ijtwz0VZGOHknMTbrJgZHsNjDHJnLK9NtohpO0A=";
    };

    mmaudio = {
      version = "git-2026-02-04-8eaeb72edc3a";
      owner = "kijai";
      repo = "ComfyUI-MMAudio";
      rev = "8eaeb72edc3aaf2059b57f2d96a1f6f689f19ae2";
      hash = "sha256-kN2Q4j3z0Z8uSZCh4sK/1f2cVa9Ymw7fOtTYl5MDEv8=";
    };

    pulid = {
      version = "2025-04-14";
      owner = "cubiq";
      repo = "PuLID_ComfyUI";
      rev = "93e0c4c226b87b23c0009d671978bad0e77289ff";
      hash = "sha256-gzAqb8rNIKBOR41tPWMM1kUoKOQTOHtPIdS0Uv1Keac=";
    };

    wanvideo = {
      hash = "sha256-/S6sr/6VXx3UxticdE+oxzRtbs+LiG54egMdqIYuB1M=";
      owner = "kijai";
      repo = "ComfyUI-WanVideoWrapper";
      rev = "088128b224242e110d3906c6750e9a3a348a659b";
      version = "git-2026-05-24-088128b22424";
    };
  };
}
