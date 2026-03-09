## Context

The current release process is manual and fragmented. We have a bash script for binaries and a GitHub Actions job for Docker images. This leads to version mismatches and manual toil. We need a unified, automated pipeline that handles both binaries and Docker images.

## Goals / Non-Goals

**Goals:**
- Unify binary and Docker releases under GoReleaser.
- Automate the entire process triggered by a git tag.
- Generate high-quality GitHub Release notes automatically.
- Ensure multi-platform binary support (Linux, Windows, macOS).
- Ensure multi-platform Docker image support (AMD64, ARM64).

**Non-Goals:**
- Rewriting the application logic.
- Changing the existing Docker registry (staying with GHCR).
- Automating the `CHANGELOG.md` generation (GoReleaser will use the existing one or tag notes).

## Decisions

### 1. Tool Selection: GoReleaser
GoReleaser is selected for its declarative configuration and native support for both Go binaries and Docker images. It replaces the custom `compile.sh` script and the manual Docker build steps in CI.

### 2. Multi-Arch Docker Strategy
GoReleaser will build binaries for each architecture (`amd64`, `arm64`). We will use a dedicated `build/docker/Dockerfile.goreleaser` that is extremely simple:
```dockerfile
FROM alpine:latest
COPY rcon /rcon
ENTRYPOINT ["/rcon"]
```
GoReleaser will then build and push the images, tagging them appropriately.

### 3. GitHub Actions Integration
The `build.yml` workflow will be updated to include a `release` job. This job will:
- Run only on tags (`v*`).
- Depend on `lint` and `test` jobs.
- Use `goreleaser/goreleaser-action`.
- Handle authentication with `GITHUB_TOKEN` for both Release creation and GHCR pushing.

### 4. Binary Version Injection
We will standardize on injecting the version into `main.Version`. The current Dockerfile uses `main.ServiceVersion` which is inconsistent with `main.go`. This will be corrected to `main.Version`.

## Risks / Trade-offs

- **[Risk] Docker Build Context** → **[Mitigation]** Use GoReleaser's `dockers` configuration to correctly map pre-built binaries into the Docker context.
- **[Risk] GITHUB_TOKEN Permissions** → **[Mitigation]** Ensure the workflow has `contents: write` and `packages: write` permissions.
- **[Trade-off] Multi-arch build time** → Building for multiple architectures increases CI time, but ensures wider compatibility for users (especially ARM64 for cloud/edge).
