# release-pipeline

Automate the release of `rcon-cli` binaries and Docker images.

## Requirements

### Release Trigger
- The release process MUST be triggered by a git tag following Semantic Versioning (e.g., `v*`).
- The release process MUST only occur on successful completion of linting and testing jobs.

### Binary Artifacts
- Binaries MUST be cross-compiled for:
    - `linux/386`, `linux/amd64`
    - `windows/386`, `windows/amd64`
    - `darwin/amd64`, `darwin/arm64`
- Binaries MUST have the version injected into `main.Version` during compilation.
- Binaries MUST be stripped of debug symbols (`-s -w`).

### Archiving and Packaging
- Linux and macOS binaries MUST be packaged as `.tar.gz` archives.
- Windows binaries MUST be packaged as `.zip` archives.
- Archives MUST contain:
    - The `rcon` binary.
    - `LICENSE`.
    - `README.md`.
    - `CHANGELOG.md`.
    - `rcon.yaml`.

### Verification
- A `checksums.txt` file MUST be generated containing SHA256 hashes of all archives.

### Docker Image
- A Docker image MUST be built and pushed to GHCR (`ghcr.io/dmirtillo/rcon-cli`).
- The Docker image MUST be tagged with:
    - The specific version tag (e.g., `v0.11.0`).
    - `latest`.
- The Docker image SHOULD be built for `linux/amd64` and `linux/arm64`.
- The image MUST use `alpine:latest` as the base image for a lightweight footprint.

### GitHub Release
- A GitHub Release MUST be automatically created.
- The release MUST include the archived binaries and the checksum file.
- The release MUST include release notes extracted from the git tag/changelog.
