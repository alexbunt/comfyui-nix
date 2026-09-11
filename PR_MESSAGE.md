# chore: refresh PyTorch stack and pinned dependencies

## Simple summary

This PR updates the Linux machine-learning stack and the remaining pinned
dependencies after incorporating the changes from #103.

In plain terms, it:

- updates PyTorch to 2.14.0 across Linux CPU, CUDA, ROCm, and Intel XPU builds;
- updates torchvision, torchaudio, Triton, TorchCodec, and their native runtimes;
- moves ROCm from 7.1 to 7.2 while keeping CUDA on the cu130 channel;
- refreshes ComfyUI frontend/template packages and selected custom nodes;
- adds runtime checks for the complete PyTorch media stack;
- keeps targeted CI workarounds for upstream tests that are unreliable in Nix sandboxes;
- avoids building PyTorch from source, which previously exhausted memory on smaller machines.

ComfyUI remains at 0.34.0. Apple Silicon remains on the known-good PyTorch
2.5.1 stack because of the existing macOS 26 MPS compatibility concern.

## Relationship to upstream PR #103

This branch is rebuilt on commit
`5e6d5155d302a015645164d195a6ad79f00ed43a` from #103.

That upstream change already refreshed flake inputs and several custom nodes,
removed Gradio packages that ComfyUI does not require, removed unsupported
Intel macOS evaluation, fixed the formatter wrapper, updated CI behavior, and
added an XPU wheel-metadata cleanup. This PR accepts those decisions instead
of reintroducing overlapping implementations.

The remaining diff focuses on the newer PyTorch/runtime matrix, additional
dependency pins, stronger integration checks, and CI stability fixes found
while validating the refreshed closure.

## PyTorch platform matrix

| Platform/backend | PyTorch | torchvision | torchaudio | Triton |
| --- | ---: | ---: | ---: | ---: |
| Linux CPU, x86_64 | 2.14.0 | 0.29.0 | 2.11.0 | 3.8.0 |
| Linux CPU, aarch64 | 2.14.0 | 0.29.0 | 2.11.0 | 3.8.0 |
| Linux CUDA 13.0 | 2.14.0 | 0.29.0 | 2.11.0 | 3.8.0 |
| Linux ROCm 7.2 | 2.14.0 | 0.29.0 | 2.11.0 | triton-rocm 3.8.0 |
| Linux Intel XPU | 2.14.0 | 0.29.0 | 2.11.0 | triton-xpu 3.8.0 |
| Apple Silicon | 2.5.1 | 0.20.1 | 2.5.1 | Not installed |

TorchAudio now versions independently from PyTorch, so torchaudio 2.11.0 is
the intended companion for this PyTorch release.

## Dependency updates

Notable explicit pin changes include:

| Dependency | Previous | Updated |
| --- | ---: | ---: |
| PyAV | 17.0.0 | 18.1.0 |
| TorchCodec | Not pinned | 0.16.0 |
| ComfyUI frontend | 1.49.6 | 1.52.7 |
| Workflow templates | 0.11.48 | 0.11.57 |
| Workflow template core | 0.3.322 | 0.3.337 |
| Workflow template JSON | 0.1.57 | 0.1.72 |
| Workflow media assets | 0.1.35 | 0.1.43 |
| Embedded documentation | 0.5.10 | 0.5.11 |
| comfy-kitchen | 0.2.31 | 0.2.33 |
| comfy-aimdo | 0.4.15 | 0.5.3 |
| comfy-angle | 0.1.0 | 0.1.1 |

All external sources remain pinned to immutable revisions and Nix hashes.
The generated template-input manifest is refreshed to 704 pinned assets.

## GPU backend changes

### CUDA

CUDA continues to use official PyTorch cu130 wheels and a CUDA 13.0 toolkit.
The runtime packages are pinned to the exact versions requested by the torch
wheel:

- cuDNN 9.24.0.43;
- NCCL 2.30.7;
- NVSHMEM 3.4.5.

The new `nix/cuda-packages.nix` helper keeps those selections in one place.
It also provides `libnvJitLink.so.13`, keeps wheel metadata consistent with
Nix-provided libraries, and leaves `libcuda.so.1` to the host driver. Optional
NVSHMEM multi-node transports remain excluded because ComfyUI does not use
them.

CUDA still requires a driver compatible with CUDA 13.0 (580 or newer).

### ROCm

ROCm moves from 7.1 to 7.2 and uses PyTorch 2.14.0, torchvision 0.29.0,
torchaudio 2.11.0, and triton-rocm 3.8.0. Triton receives its required bzip2,
xz, and zstd libraries.

### Intel XPU

The XPU package moves to PyTorch 2.14.0 and pins the exact oneAPI/SYCL, MKL,
TBB, oneCCL, Intel MPI, Level Zero, Triton XPU, and `pyzes` dependencies
declared by the official wheel. `pyelftools` is included for Triton XPU.

The XPU wheel's PyPI-only runtime requirements are removed from installed
metadata after the equivalent Nix packages are wired into the closure. This
retains the cleanup introduced by #103 while covering the complete updated
runtime set. IPEX remains unnecessary because ComfyUI uses `torch.xpu`.

### Linux CPU and macOS

Both Linux architectures now use official CPU wheels, giving every Linux
backend a consistent PyTorch release family without compiling PyTorch locally.

Apple Silicon deliberately stays on PyTorch 2.5.1 until representative
ComfyUI workflows can be tested against newer MPS builds on macOS 26. Intel
macOS is not restored; the supported systems remain aligned with #103.

## Media support

TorchCodec 0.16.0 is packaged for Linux and integrated with torchaudio. All
Linux backends use the CPU TorchCodec wheel with FFmpeg 9 because audio decode
does not need GPU kernels and the PyPI Linux wheel would add an unwanted CUDA
dependency to CPU, ROCm, and XPU closures.

PyAV is updated to 18.1.0 using platform-specific wheels pinned in
`nix/versions.nix`.

## Custom nodes

The dependency-refresh work retains the custom-node updates already present in
#103. On top of that base:

- Impact Pack moves to `429d0159ad42`;
- KJNodes moves from #103's `c9869eade992` to `57105374f47d`.

## Packaging and runtime checks

The new `nix/linux-python-wheels.nix` centralizes Linux wheel packaging for
PyTorch, torchvision, torchaudio, Triton, and TorchCodec.

Each Linux backend runtime check now imports the full stack and verifies that:

- the imported versions match the Nix-selected versions;
- backend packages did not silently fall back to nixpkgs' CPU torch;
- removed wheel requirements are absent from installed torch metadata;
- `torchvision.ops.nms()` loads and executes;
- torchaudio saves and reloads a waveform through TorchCodec;
- the CPU package compiles and runs a small `torch.compile`/Inductor graph.

The backend checks are separate outputs so CI does not realize every
multi-gigabyte GPU closure in one job. NixOS-only module checks remain gated to
Linux.

## CI stability fixes

The nixpkgs refresh exposed upstream tests whose assertions are sensitive to
allocator state, exact timing, or loaded CI workers. The workarounds are
intentionally narrow:

- PyArrow excludes `test_batch_lifetime`, whose allocator threshold differed
  by one 128-byte block after more than 7,700 passing tests.
- Jupyter Server excludes two orphaned-kernel disconnect tests whose cleanup
  can time out and temporarily report leaked descriptors under load.
- Django excludes one crafted-XML wall-clock scaling assertion and runs its
  custom suite with `--parallel=1`, preventing auto-detected worker counts from
  exhausting memory.
- ImageIO excludes only its PyAV-specific write-test path.
- `inline-snapshot` excludes only its formatter-version-dependent docs test.
- `backrefs` excludes its wall-clock timeout test.
- Accelerate receives OpenSSL for PyTorch 2.14 header hashing; its existing
  compiler-related test exclusion remains GPU-only.

The functional portions of these packages' test suites remain enabled.

## Other changes

- The model downloader moves blocking path operations to `asyncio.to_thread()`
  so they do not block aiohttp's event loop.
- `.envrc` enables `accept-flake-config` for non-interactive nix-direnv use.
- README and maintainer documentation describe the updated runtime matrix and
  hardware-validation expectations.
- `docs/dependency-refresh-2026-09.md` records the pin audit in detail.

## Validation

Completed during this dependency refresh:

- all-system flake evaluation with constrained concurrency;
- the default Linux CPU package and CPU PyTorch runtime check;
- separate CUDA, ROCm, and XPU runtime/import checks;
- torchvision NMS and torchaudio/TorchCodec waveform round trips;
- the CPU `torch.compile` smoke test;
- project Python tests (38 passed);
- isolated PyArrow, Jupyter Server, and serialized Django builds after their
  narrow exclusions;
- Nix formatting and Git whitespace checks.

The fully parallel `nix flake check -L --keep-going` is intentionally not used
locally: it realizes several large accelerator closures simultaneously and can
OOM smaller development machines. Backend checks should instead be built
separately with constrained jobs.

Physical-device acceptance is still required for CUDA, ROCm, XPU, and Apple
Silicon MPS. Build-time imports and CPU-executable operations cannot establish
that device kernels work correctly on every supported GPU.

## Compatibility notes

- Python remains at 3.12.
- ComfyUI remains at 0.34.0.
- Apple Silicon remains on PyTorch 2.5.1.
- CUDA remains on cu130; ROCm moves to 7.2.
- Gradio remains removed, matching #103 and ComfyUI's actual dependencies.
- Intel macOS remains unsupported, matching current nixpkgs and #103.
- No user-facing configuration migration is required.
