## Why

The current GitHub Actions CI workflow (`.github/workflows/build.yml`) contains a single, monolithic job (`build`) that executes linting, testing, and compilation sequentially. This monolithic design obscures the precise point of failure when viewing pull requests, prevents parallel execution of independent tasks (like linting and testing), and doesn't explicitly block the downstream `docker-release` job on a successful build. We need to refactor the pipeline into smaller, descriptive jobs to improve visibility, "fail fast" on lint errors, and ensure that Docker images are only published when the code passes all checks.

## What Changes

- Split the monolithic `build` job in `.github/workflows/build.yml` into distinct, granular jobs (e.g., `lint`, `test`, `build`).
- Configure the jobs to run in parallel where possible (e.g., `lint` and `test` can run simultaneously).
- Add a dependency (`needs:`) to the `docker-release` job so that it only runs if the `lint`, `test`, and `build` jobs complete successfully.

## Capabilities

### New Capabilities
- `ci-pipeline-refactor`: Specifications for granular CI jobs and their dependencies.

### Modified Capabilities
- `docker-ci-validation`: Modify the requirement around when the Docker publishing job runs, making it explicitly dependent on successful prior CI jobs.

## Impact

- `.github/workflows/build.yml`
- The developer experience on GitHub when reviewing PRs (clearer status checks).
