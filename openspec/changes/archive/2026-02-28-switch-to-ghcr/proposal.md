## Why

The current CI pipeline is configured to push Docker images to Docker Hub using the `outdead/rcon` namespace, which requires specific external secrets (`GORCON_DOCKER_TOKEN`). For a forked repository (`dmirtillo/rcon-cli`), migrating to GitHub Container Registry (GHCR) simplifies setup by utilizing the built-in `GITHUB_TOKEN`, removing the need for manual secret configuration before enabling workflows.

## What Changes

- Update the `.github/workflows/build.yml` login step to authenticate against `ghcr.io` using `secrets.GITHUB_TOKEN`.
- Update all image tagging references in the workflow from `outdead/rcon` to `ghcr.io/dmirtillo/rcon-cli`.
- Add explicit `packages: write` permissions to the workflow to allow pushing to GHCR.
- *Note: This change does not affect the CLI interface (flags/commands) nor any protocol-specific logic (RCON vs WebRCON).*

## Capabilities

### New Capabilities
*(None)*

### Modified Capabilities
- `docker-ci-validation`: The existing validation pipeline now targets GHCR instead of Docker Hub.

## Impact

- **CI/CD**: Modifications to `.github/workflows/build.yml`.
- **Infrastructure**: The published Docker artifact will now reside at `ghcr.io/dmirtillo/rcon-cli` instead of Docker Hub.
