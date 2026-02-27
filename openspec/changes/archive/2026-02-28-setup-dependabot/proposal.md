## Why

Currently, the project lacks automated dependency updates, and there is a discrepancy between the Go versions used across the repository (`go 1.21` in `go.mod`, `1.21.6` in `.github/workflows/build.yml`, and `1.19.3` in `build/docker/Dockerfile`). This change addresses the version mismatch to prevent build failures and introduces Dependabot to safely automate ongoing dependency updates grouped by ecosystem.

## What Changes

- Add Dependabot configuration (`.github/dependabot.yml`) for Go modules, GitHub Actions, and Docker.
- Configure Dependabot to run weekly and target the `develop` branch.
- Use Dependabot "groups" feature to bundle all non-major updates together (e.g., all go module updates in one PR, all action updates in another).
- Configure Dependabot to ignore toolchain updates for the main `go` version to maintain stability until a coordinated upgrade is planned.
- Update `build/docker/Dockerfile` to use Go `1.21` (matching `go.mod`), resolving the current version discrepancy.
- *Note: This change does not affect the CLI interface (flags/commands) nor any protocol-specific logic (RCON vs WebRCON).*

## Capabilities

### New Capabilities
*(None)*

### Modified Capabilities
*(None)*

## Impact

- **Infrastructure:** Adds `.github/dependabot.yml` which will automatically generate PRs into `develop` on a weekly basis.
- **Docker:** Updates the base image in `build/docker/Dockerfile` to a Go 1.21 compatible tag, unifying the toolchain version.
- **Dependencies:** Eases the maintenance burden by keeping Go modules and GitHub Actions up-to-date.
