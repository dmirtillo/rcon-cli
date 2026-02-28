## ADDED Requirements

### Requirement: Docker Builder Go Version
The Dockerfile builder stage MUST use a Go runtime version of 1.22+ to compile the application consistently with the local and CI pipelines.

#### Scenario: Verify Dockerfile builder image
- **WHEN** the Docker image is built
- **THEN** the builder stage image tag is `golang:1.22-alpine` (or a newer 1.22.x patch version)
