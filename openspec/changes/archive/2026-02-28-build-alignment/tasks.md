## 1. Dependency Modernization

- [x] 1.1 Update `go.mod` to specify `go 1.22`.
- [x] 1.2 Update `build/docker/Dockerfile` builder stage to use `golang:1.22-alpine`.
- [x] 1.3 Update `.github/workflows/build.yml` to use `actions/setup-go@v5` and set `go-version: 1.22.x`.
- [x] 1.4 Update `.github/workflows/build.yml` to use a newer `golangci-lint-action` (e.g., `v1.56.2` or later).
- [x] 1.5 Run `go get -u ./...` and `go mod tidy` to update upstream dependencies.

## 2. Local Makefile Alignment

- [x] 2.1 Add `deps` target to `scripts/local/local.mk` to run `go mod download` and `go mod verify`.
- [x] 2.2 Add `test` target to `scripts/local/local.mk` to run `go test -v ./...`.
- [x] 2.3 Add `build` target to `scripts/local/local.mk` to run `go build -v ./cmd/gorcon`.

## 3. CI Pipeline Alignment

- [x] 3.1 Replace manual `go get` step in `.github/workflows/build.yml` with `make deps`.
- [x] 3.2 Replace manual `go test` step in `.github/workflows/build.yml` with `make test`.
- [x] 3.3 Replace manual `go build` step in `.github/workflows/build.yml` with `make build`.

## 4. Verification

- [x] 4.1 Run `make deps`, `make test`, and `make build` locally to ensure the new targets function as expected.
- [x] 4.2 Run `make lint` locally to ensure the codebase passes any updated linter checks.
- [x] 4.3 Verify that tests continue to pass after the `go get -u` dependency updates.
