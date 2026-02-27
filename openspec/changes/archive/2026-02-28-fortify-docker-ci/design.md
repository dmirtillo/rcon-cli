## Context

The repository uses GitHub Actions for CI/CD. The Docker build process is triggered on pushes to `master` and `develop` and on tags. Currently, the `docker-release` job builds and pushes immediately. We need to introduce a validation phase to ensure image quality and security.

## Goals / Non-Goals

**Goals:**
- Implement Dockerfile linting.
- Implement runtime smoke testing of the built image.
- Implement vulnerability scanning of the built image.
- Ensure the push only occurs if all validations pass.

**Non-Goals:**
- Moving the Docker build to a different registry.
- Implementing a full integration test suite against a live RCON server (mocking/smoke test only).

## Decisions

- **Use `hadolint/hadolint-action`**: Industry standard for Dockerfile linting.
- **Split Build into two steps**: 
    1. **Verification Build**: Build with `load: true` and `push: false`. This loads the image into the local runner's Docker daemon.
    2. **Push Build**: Build with `push: true`. This uses Docker's layer caching, making it fast as long as the Dockerfile hasn't changed between steps.
- **Runtime Check via `docker run`**: Execute `./rcon --help` to verify the binary is executable and linked correctly in the Alpine environment.
- **Use `aquasecurity/trivy-action`**: Robust and fast vulnerability scanner for both OS packages and language-specific dependencies (Go).

## Risks / Trade-offs

- **Risk**: Increased CI runtime.
    - *Mitigation*: Docker layer caching between the verification and push steps keeps the overhead minimal.
- **Risk**: Flaky tests if the smoke test depends on external state.
    - *Mitigation*: Keep the smoke test limited to `--help` or `--version`, which only tests binary integrity.
- **Trade-off**: `load: true` does not support multi-platform builds in a single command.
    - *Decision*: Build only for `linux/amd64` during the verification phase to keep it fast and compatible with the local runner.
