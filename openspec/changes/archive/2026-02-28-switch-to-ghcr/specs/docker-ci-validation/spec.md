## MODIFIED Requirements

### Requirement: Atomic Publish
The CI pipeline SHALL only push images to the registry if all validation steps (lint, smoke test, security scan) have passed.

#### Scenario: Smoke test fails
- **WHEN** the runtime verification fails
- **THEN** the subsequent `Build and publish` step is skipped or aborted

#### Scenario: All validations pass
- **WHEN** all validation steps succeed
- **THEN** the Docker artifact is published to GHCR (`ghcr.io/dmirtillo/rcon-cli`) using the provided `GITHUB_TOKEN` for authentication
