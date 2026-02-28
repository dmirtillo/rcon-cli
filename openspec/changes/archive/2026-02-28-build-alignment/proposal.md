## Why

The current build and test processes suffer from fragmentation and pipeline drift. Developers run a cross-compilation release script locally (`make compile`), while the CI pipeline on GitHub Actions runs manual Go commands (like `go test` and `go build`). There is no simple local `make test` or `make build` target, and the Go version (1.21) is hardcoded and outdated. Aligning the local Make targets with the CI workflow steps and modernizing the dependencies ensures that local tests perfectly mimic the CI environment, boosting developer confidence and reducing the risk of drift.

## What Changes

- Overhaul `scripts/local/local.mk` to include unified `deps`, `test`, and `build` targets.
- Update GitHub Actions workflow (`.github/workflows/build.yml`) to use the new Makefile targets (`make deps`, `make test`, `make build`) instead of manual Go commands.
- Bump the Go version from 1.21 to 1.22 (or latest stable) in `go.mod`, `.github/workflows/build.yml`, and `build/docker/Dockerfile`.
- Update dependencies (e.g., `github.com/gorcon/rcon`, `testify`) via `go get -u ./...` and `go mod tidy`.
- Update the `golangci-lint-action` version to align with the new Go version.

## Capabilities

### New Capabilities
- `build-alignment`: Standardized local build targets mirroring the CI environment with modernized dependencies.

### Modified Capabilities
- `docker-ci-validation`: The underlying Go version for the builder image is updated to 1.22+.

## Impact

- `Makefile` and `scripts/local/local.mk`
- `go.mod` and `go.sum`
- `.github/workflows/build.yml`
- `build/docker/Dockerfile`
- All project source files (to the extent that dependency updates or linter changes affect them).
