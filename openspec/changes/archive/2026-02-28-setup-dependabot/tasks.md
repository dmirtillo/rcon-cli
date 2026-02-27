## 1. Docker Environment Alignment

- [x] 1.1 Update `build/docker/Dockerfile` base image from `golang:1.19.3-alpine` to `golang:1.21-alpine` to ensure the toolchain version aligns with `go.mod`.

## 2. Dependabot Configuration

- [x] 2.1 Create `.github/dependabot.yml`.
- [x] 2.2 Add configuration for the `gomod` ecosystem: target `develop`, schedule `weekly`, add `ignore` block for the `go` dependency, and group all other updates.
- [x] 2.3 Add configuration for the `github-actions` ecosystem: target `develop`, schedule `weekly`, and group all action updates.
- [x] 2.4 Add configuration for the `docker` ecosystem: point to directory `/build/docker/`, target `develop`, schedule `weekly`, and group all docker updates.
