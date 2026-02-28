# Build and Test Alignment Specification

## Objective
To standardize and modernize the compilation, testing, and dependency management processes across local development environments and the continuous integration (CI) pipeline on GitHub Actions.

## Current State Analysis
*   **Go Version**: Hardcoded to 1.21 in `go.mod`, `build/docker/Dockerfile`, and `.github/workflows/build.yml`.
*   **Local Targets**: `Makefile` supports `compile` (which runs an SH script for cross-compiling releases), `run`, and `lint`. There is no dedicated `test` or simple `build` target for quick local validation.
*   **CI Drift**: The GitHub workflow runs explicit manual steps (`go get`, `go test`, `go build`) rather than leveraging the same automated scripts available to developers, creating potential for pipeline drift.

## Plan & Requirements

### 1. Standardize Local Build Tooling
We must introduce uniform entry points in the `Makefile` (specifically via `scripts/local/local.mk`) to wrap standard Go operations:
*   `make deps`: Ensure all dependencies are downloaded and verified (e.g., `go mod download` and `go mod verify`).
*   `make test`: Execute unit tests locally (e.g., `go test -v ./... -race`).
*   `make build`: A quick local compilation target (e.g., `go build -v ./cmd/gorcon`), distinct from the full cross-compilation release script (`compile.sh`).

### 2. Dependency Modernization
*   **Go Runtime**: Bump the required Go version from 1.21 to 1.22 (or latest stable) in:
    *   `go.mod`
    *   `build/docker/Dockerfile` (change `golang:1.21-alpine` to `golang:1.22-alpine`)
    *   `.github/workflows/build.yml` (update `actions/setup-go@v4` to `v5` and set `go-version: 1.22.x`)
*   **Linters**: Update `golangci/golangci-lint-action` to the latest compatible version (e.g., v1.56+).
*   **Go Packages**: Run `go get -u ./...` and `go mod tidy` to freshen upstream library dependencies (e.g., `github.com/gorcon/rcon`, `testify`).

### 3. CI/CD Pipeline Alignment
The GitHub Actions workflow (`.github/workflows/build.yml`) must be refactored to align with the new standardized Makefile targets:
*   Replace manual `go get` with `make deps`.
*   Replace manual `go test` with `make test`.
*   Replace manual `go build` with `make build`.
*   Ensure the `golangci-lint` step config is synced with the latest local configuration.
*   Validate that Docker release stages continue to work flawlessly with the new Go builder image.

### Requirement: Standardized Make Targets
The `scripts/local/local.mk` MUST provide dedicated `deps`, `test`, and `build` targets to run Go module downloading, testing, and compilation respectively.

#### Scenario: Running make test locally
- **WHEN** a developer executes `make test` locally
- **THEN** the `go test -v ./... -race` command is executed successfully

#### Scenario: Running make build locally
- **WHEN** a developer executes `make build` locally
- **THEN** the `go build -v ./cmd/gorcon` command is executed successfully

### Requirement: Unified CI Execution
The `.github/workflows/build.yml` file MUST use the Makefile targets instead of invoking Go commands manually.

#### Scenario: CI pipeline runs tests
- **WHEN** the "Test" step executes in GitHub Actions
- **THEN** it runs `make test` rather than `go test ./...`

### Requirement: Go Version Alignment
All project files specifying the Go runtime version MUST be updated to 1.22 consistently.

#### Scenario: Verify go.mod version
- **WHEN** the Go version is evaluated
- **THEN** `go.mod` indicates `go 1.22`

## Acceptance Criteria
1. Developer running `make test` locally executes the exact same process as the GitHub Actions `Test` step.
2. All project components (Go module, Dockerfile, GitHub Actions) reference the updated Go version uniformly.
3. Code compiles and tests pass with 0 errors after dependency updates.
