## ADDED Requirements

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
