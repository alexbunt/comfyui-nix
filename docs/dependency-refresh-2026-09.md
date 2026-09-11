# Dependency refresh — 2026-09-09

The update targets stable releases available on 2026-09-09, using Python 3.12.
All wheel URLs and hashes come from PyPI or the official PyTorch wheel indexes.
Git sources use immutable commits and Nix unpacked hashes.

## PyTorch platform matrix

| Platform/backend | torch | torchvision | torchaudio | Triton |
| --- | --- | --- | --- | --- |
| Linux CPU (x86_64, aarch64) | 2.14.0 | 0.29.0 | 2.11.0 | 3.8.0 |
| Linux CUDA 13.0 (x86_64) | 2.14.0 | 0.29.0 | 2.11.0 | 3.8.0 |
| Linux ROCm 7.2 (x86_64) | 2.14.0 | 0.29.0 | 2.11.0 | triton-rocm 3.8.0 |
| Linux Intel XPU (x86_64) | 2.14.0 | 0.29.0 | 2.11.0 | triton-xpu 3.8.0 |
| Apple Silicon | 2.5.1 retained | 0.20.1 retained | 2.5.1 retained | Not installed |
| Intel macOS | From nixpkgs 26.05 | From nixpkgs 26.05 | From nixpkgs 26.05 | Not installed |

[TorchAudio 2.11 supports subsequent PyTorch versions](https://docs.pytorch.org/audio/main/installation.html);
its version no longer advances with torch. Linux audio I/O uses the CPU build
of TorchCodec 0.16.0 with FFmpeg 9, including when torch uses a GPU backend.
PyPI's Linux TorchCodec wheel links CUDA, so it is unsuitable for the CPU/ROCm/XPU packages.

CUDA retains the cu130 channel and a matching nixpkgs CUDA 13.0 toolkit.
cuDNN 9.24.0.43, NCCL 2.30.7, and NVSHMEM 3.4.5 are pinned to torch's wheel
requirements; cuda-bindings is provided by the matching nixpkgs override.
ROCm uses the available 2.14 wheel with bundled ROCm 7.2 libraries. Moving to
the modular ROCm 7.14 distribution would also require packaging its separate
device/runtime dependency graph and validating hardware coverage.
Intel runtimes follow torch's exact requirements (oneAPI/MKL 2026.1, TBB
2023.1, oneCCL 2022.1.1, MPI 2021.18.1, and the remaining pins in versions.nix).
The new pyzes Python dependency is installed separately from the combined
native-library derivation.

## Other explicit pins

| Pin | Previous | Selected |
| --- | --- | --- |
| av | 17.0.0 | 18.1.0 |
| color-matcher | 0.6.0 | 0.6.0 |
| comfyAimdo | 0.4.15 | 0.5.3 |
| comfyAngle | 0.1.0 | 0.1.1 |
| comfyKitchen | 0.2.31 | 0.2.33 |
| embeddedDocs | 0.5.10 | 0.5.11 |
| facexlib | 0.3.0 | 0.3.0 |
| frontendPackage | 1.49.6 | 1.52.7 |
| gradio | 5.49.1 | 6.26.0 |
| gradioClient | 1.13.3 | 2.6.1 |
| manager | 4.2.2 | 4.2.2 |
| pyarrowDarwinX86_64 | New | 25.0.1 |
| sageattention | 1.0.6 | 1.0.6 |
| sam2 | 1.0 | 1.0 |
| segment-anything | 1.0 | 1.0 |
| spandrel | 0.4.2 | 0.4.2 |
| torchcodec | New | 0.16.0 |
| workflowTemplates | 0.11.48 | 0.11.57 |
| workflowTemplatesCore | 0.3.322 | 0.3.337 |
| workflowTemplatesJson | 0.1.57 | 0.1.72 |
| workflowTemplatesMediaApi | 0.3.84 | 0.3.84 |
| workflowTemplatesMediaAssets01 | 0.1.35 | 0.1.43 |
| workflowTemplatesMediaImage | 0.3.160 | 0.3.160 |
| workflowTemplatesMediaOther | 0.3.229 | 0.3.229 |
| workflowTemplatesMediaVideo | 0.3.101 | 0.3.101 |

ComfyUI remains 0.34.0: the latest stable GitHub release at the audit date.
Manager, Spandrel, facexlib, color-matcher, and the unchanged template media
packages already have the latest PyPI releases. SageAttention 1.0.6 remains
the published portable wheel; the upstream GitHub releases endpoint has no
stable release to select. SAM and SAM2 source revisions were already current.

## Custom nodes

| Node | Previous commit | Selected commit |
| --- | --- | --- |
| bitsandbytes-nf4 | 6c65152bc48b | 6c65152bc48b |
| florence2 | 606bc5cd3465 | 9ece3de91421 |
| gguf | 6ea2651e7df6 | 6ea2651e7df6 |
| impact-pack | 8.28 | 429d0159ad42 |
| kjnodes | c88ac88a8f8a | 57105374f47d |
| ltxvideo | 3b9c5cde4700 | 15d09abb5a18 |
| mmaudio | 8eaeb72edc3a | 8eaeb72edc3a |
| pulid | 93e0c4c226b8 | 93e0c4c226b8 |
| rgthree-comfy | 6b76ee6f2c5a | 2c5342a8cb0e |
| wanvideo | df8f3e49daaa | 088128b22424 |
| x-flux | 00328556efc9 | 00328556efc9 |

Release tags were checked against the existing commit dates. For repositories
without a current release, the latest default-branch commit was used.
Older release tags were not allowed to replace newer existing pins.

## Flake inputs and compatibility exceptions

- nixpkgs, flake-parts, and nixpkgs-lib are refreshed in flake.lock.
- The separate CI runtime-dependency nixpkgs pin matches the new main input.
- Current unstable nixpkgs removed Intel macOS support. That platform uses the
  maintained nixpkgs-26.05-darwin input instead.
- Intel macOS uses a PyArrow 25.0.1 wheel to avoid its broken Arrow C++ build.
  Ultralytics is omitted there because upstream marks it unsupported after
  native test crashes; YOLO detector nodes require a supported platform.
- Apple Silicon retains its MPS workaround until inference can be tested on
  macOS 26. Closing the referenced upstream issue alone does not validate the
  application workflow.
- Python remains 3.12, the common ABI for the wheel matrix.
- Native platform wheels are retained for Kitchen/Aimdo/ANGLE.
- PyAV's platform wheel pins now live in versions.nix.
- The launcher derives its Hugging Face Hub constraint from the selected
  package, avoiding the obsolete <1.0 bound with Transformers 5/Gradio 6.
- nixfmt-tree preserves the documented no-argument `nix fmt` command.

## Validation

The runtime dependency checks import torch, torchvision, torchaudio, Triton,
and TorchCodec, check selected versions, execute torchvision NMS on CPU, and
save/load a waveform. These checks catch shared-library and codec integration
errors without requiring a GPU.
The CPU check also executes a small graph through torch.compile/Inductor.

Run the quality gate:

```sh
nix flake check --no-build --all-systems
nix flake check -L --keep-going
```

The hardware acceptance step is still required on CUDA, AMD, Intel, and macOS
hosts: launch ComfyUI with an isolated base directory, run a representative
image workflow and audio workflow, and exercise `torch.compile`/Triton on the
actual device. Build success does not establish GPU correctness.
