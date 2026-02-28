## 1. Refactor Go CI Jobs

- [x] 1.1 Remove the monolithic `build` job in `.github/workflows/build.yml`.
- [x] 1.2 Create a standalone `lint` job that checks out code, sets up Go, and runs the `golangci/golangci-lint-action`.
- [x] 1.3 Create a standalone `test` job that checks out code, sets up Go, gets dependencies, and runs `make test`. Include coverage reporting here.
- [x] 1.4 Create a standalone `build` job that checks out code, sets up Go, gets dependencies, and runs `make build`.

## 2. Docker CI Validation Job Dependencies

- [x] 2.1 Update the `docker-release` job in `.github/workflows/build.yml` to explicitly require `lint`, `test`, and `build` jobs to complete successfully using the `needs:` keyword.

## 3. Verification

- [x] 3.1 Verify that the GitHub Actions YAML syntax is correct and valid.
