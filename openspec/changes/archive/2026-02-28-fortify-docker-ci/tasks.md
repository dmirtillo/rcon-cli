## 1. Dockerfile Linting

- [x] 1.1 Add `hadolint` step to `.github/workflows/build.yml` within the `docker-release` job.
- [x] 1.2 Verify that a local `Dockerfile` with errors (e.g., using `latest` tag) triggers a failure in a dry run or local test if possible.

## 2. Validation Build

- [x] 2.1 Update the `docker/build-push-action` in `.github/workflows/build.yml` to include a validation step with `load: true`, `push: false`, and `tags: outdead/rcon:test`.
- [x] 2.2 Configure this step to only build for the native runner architecture (`linux/amd64`) to ensure compatibility with `load: true`.

## 3. Runtime & Security Verification

- [x] 3.1 Add a smoke test step that runs `docker run --rm outdead/rcon:test --help` and asserts exit code 0.
- [x] 3.2 Add a `trivy` scan step using `aquasecurity/trivy-action` to scan `outdead/rcon:test`.
- [x] 3.3 Configure `trivy` to fail the build on `CRITICAL` vulnerabilities.

## 4. Atomic Publish

- [x] 4.1 Update the final `Build and publish` step in `.github/workflows/build.yml` to ensure it only runs if the validation build, smoke test, and security scan steps all succeeded.
- [x] 4.2 Verify that the final publish step still supports multi-platform builds (`linux/amd64,linux/arm64/v8`).
