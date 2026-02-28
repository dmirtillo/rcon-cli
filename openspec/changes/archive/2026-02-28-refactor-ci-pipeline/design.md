## Context

The GitHub Actions workflow currently has a monolithic `build` job containing sequential steps for linting, testing, and compiling the Go application. Additionally, a separate `docker-release` job builds and publishes Docker images. The problem is that the `docker-release` job is completely independent of the `build` job, which means it could potentially build and publish an image even if the Go application fails to compile or fails tests. Furthermore, linting and testing run sequentially rather than in parallel, slowing down the feedback loop for PRs.

## Goals / Non-Goals

**Goals:**
- Break the monolithic `build` job down into modular, parallelized jobs (`lint`, `test`, `build`).
- Explicitly block the `docker-release` job from running until `lint`, `test`, and `build` have successfully passed.
- Provide a clear, descriptive status for each step of the CI process in the GitHub PR interface.

**Non-Goals:**
- Changing the underlying tools used (Make, golangci-lint, go test). We are only orchestrating the GitHub Actions jobs differently.
- Changing the release workflow or tagging strategy.

## Decisions

- **Job Splitting:** We will create three new jobs to replace the monolithic `build` job:
  - `lint`: Runs `golangci-lint` (and `make deps` if needed).
  - `test`: Runs `make test`.
  - `build`: Runs `make build`.
- **Parallelism vs Efficiency:** Splitting jobs requires checking out code and setting up Go for each job. While this incurs minor setup overhead, the ability to run linting and testing concurrently, coupled with clearer failure attribution on GitHub UI, justifies the split.
- **Workflow Dependencies:** We will add `needs: [lint, test, build]` to the `docker-release` job to strictly enforce that images are only published for verified code.

## Risks / Trade-offs

- **[Slightly Increased Overall CI Execution Time]** → Mitigation: GitHub Actions runner startup is fast, but repeating checkout and Go setup across multiple jobs does add minor overhead. The benefit of parallel execution and clarity outweighs this slight increase.

## Migration Plan

Update `.github/workflows/build.yml` in a single PR to apply the new job structure and dependencies. Monitor the first CI run carefully.
