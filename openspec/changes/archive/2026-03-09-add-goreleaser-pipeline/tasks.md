## 1. Setup and Preparation

- [x] 1.1 Create `build/docker/Dockerfile.goreleaser` for GoReleaser-based builds.
- [x] 1.2 Correct the Docker build-arg and `-ldflags` in the existing `build/docker/Dockerfile` to use `main.Version` instead of `main.ServiceVersion` (Bug Fix).
- [x] 1.3 Create the `.goreleaser.yaml` configuration file in the project root.

## 2. GoReleaser Configuration

- [x] 2.1 Configure `builds` for Linux, Windows, and Darwin (AMD64, 386, ARM64).
- [x] 2.2 Configure `archives` to include `LICENSE`, `README.md`, `CHANGELOG.md`, and `rcon.yaml`.
- [x] 2.3 Configure `checksum` to use SHA256.
- [x] 2.4 Configure `dockers` to build multi-arch images (`amd64`, `arm64`) using `Dockerfile.goreleaser`.
- [x] 2.5 Configure `release` to use the existing `CHANGELOG.md` or git notes.

## 3. GitHub Actions Integration

- [x] 3.1 Update `.github/workflows/build.yml` to add the `release` job triggered on `v*` tags.
- [x] 3.2 Add login steps for GHCR in the `release` job.
- [x] 3.3 Add the `goreleaser/goreleaser-action` step.
- [x] 3.4 Ensure the job has proper permissions (`contents: write`, `packages: write`).

## 4. Cleanup and Documentation

- [x] 4.1 Remove/Deprecate `scripts/local/compile.sh`.
- [x] 4.2 Document the new release process in `CONTRIBUTING.md` or a new `RELEASING.md`.
- [x] 4.3 Verify the configuration with `goreleaser check` (if available locally).

## 5. Validation

- [x] 5.1 Push a test tag (e.g., `v0.11.0-rc1`) to verify the end-to-end pipeline.
- [x] 5.2 Verify binaries are attached to the release.
- [x] 5.3 Verify Docker image is pushed to GHCR with correct tags.
