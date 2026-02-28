## Context

The current build and test processes have drifted between the local environment and the CI pipeline (GitHub Actions). The local `Makefile` does not have dedicated targets for `build` or `test` and instead relies on `compile.sh` for cross-platform releases. Meanwhile, the CI pipeline manually runs `go test ./...` and `go build ./cmd/gorcon`. Furthermore, the Go version is hardcoded to 1.21 in several places (`go.mod`, `build/docker/Dockerfile`, `.github/workflows/build.yml`). This design addresses these discrepancies by standardizing Make targets and unifying the Go runtime version.

## Goals / Non-Goals

**Goals:**
- Provide a seamless and identical testing and building experience locally as in CI.
- Update the Go version across all project components uniformly to 1.22 (or latest stable).
- Ensure all CI validations still pass and produce the same Docker images for multi-arch deployment.
- Modernize dependencies to keep upstream library integration healthy.

**Non-Goals:**
- We are not redesigning the release process (the `make compile` and `compile.sh` logic will remain as is for creating release archives).
- We are not changing the application architecture or business logic.

## Decisions

- **Makefile refactor for Local vs Release:** We will add `deps`, `test`, and `build` targets to `scripts/local/local.mk`. This separates standard development commands from the full cross-compilation release (`compile`). CI will rely strictly on these new `make` targets.
- **Go Version Bump:** We will bump to Go 1.22 in `go.mod`. In `.github/workflows/build.yml`, we will update the `actions/setup-go` action to `v5` (which supports newer features and caching out of the box). In `build/docker/Dockerfile`, we will use `golang:1.22-alpine` to maintain small image sizes while benefiting from newer Go runtime optimizations.
- **Linter Alignment:** We will bump `golangci-lint-action` to at least `v1.56.0` to ensure compatibility with Go 1.22 syntax and features.

## Risks / Trade-offs

- **[Dependency Breaking Changes]** → Mitigation: We will run the test suite immediately after `go get -u ./...` and `go mod tidy` before committing. Any breaking changes from `github.com/gorcon/rcon` or others will need minor codebase fixes.
- **[CI Pipeline Failures due to `actions/setup-go@v5`]** → Mitigation: We will closely monitor the CI pipeline run and adjust the `go-version` syntax if the action expects a different format (e.g., `1.22.x`).
