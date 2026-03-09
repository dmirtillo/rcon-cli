## Why

The current release process relies on a custom bash script (`scripts/local/compile.sh`) that manually handles cross-compilation, archiving, and checksum generation (using MD5). This process is disconnected from the GitHub Actions Docker release job, leading to potential inconsistencies between binary and Docker releases.

By migrating to GoReleaser, we adopt an industry-standard, declarative approach that:
- Synchronizes binary and Docker image releases from a single source of truth (the git tag).
- Automates the generation of GitHub Releases with rich changelog notes.
- Uses secure SHA256 checksums.
- Simplifies CI maintenance by replacing complex bash scripts with a well-supported GitHub Action.

## What Changes

- **Add `.goreleaser.yaml`**: Configuration for cross-platform builds, archives, checksums, and Docker image pushing.
- **Update GitHub Actions**: Modify `.github/workflows/build.yml` to trigger GoReleaser on `v*` tags.
- **Add `build/docker/Dockerfile.goreleaser`**: A lightweight Dockerfile optimized for GoReleaser (pre-built binary COPY).
- **Deprecate `scripts/local/compile.sh`**: Remove the manual build script once the pipeline is verified.
- **Fix Version Variable**: Ensure consistency in `-ldflags` between GoReleaser and the application (`main.Version`).

## Capabilities

### New Capabilities
- `release-pipeline`: Automated release management including cross-platform binaries, archives, and Docker images pushed to GHCR on git tags.

### Modified Capabilities
- (None)

## Impact

- **CI/CD**: `.github/workflows/build.yml` will now handle full releases.
- **Distribution**: Users will find binaries and checksums directly on the GitHub Releases page.
- **Security**: Migration from MD5 to SHA256 for binary verification.
- **Docker**: Images will be consistently tagged with both the version and `latest`.
