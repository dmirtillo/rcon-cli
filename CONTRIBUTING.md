# Contributing to rcon-cli

First off, thank you for considering contributing to `rcon-cli`! 

## Local Development & CI Alignment

To ensure a smooth developer experience and avoid "it works on my machine" issues, our local development environment is strictly aligned with our GitHub Actions Continuous Integration (CI) pipeline. 

The CI pipeline runs exactly the same commands as the ones available locally via `make`.

### Prerequisites
- **Go**: Version `1.26` or higher.
- **Docker**: (Optional, but recommended) Used for building the Docker release images and running isolated tests.
- **Make**: Used for standardizing build and test tasks.

### Standardized `make` Targets

We use `make` to wrap standard Go operations. Please use these commands during development to ensure your code will pass CI:

*   **`make deps`**: Downloads and verifies Go modules.
    ```bash
    make deps
    ```

*   **`make test`**: Runs the entire test suite locally. CI requires this to pass with 0 errors.
    ```bash
    make test
    ```

*   **`make build`**: Compiles the `rcon` binary quickly for local validation.
    ```bash
    make build
    ```

*   **`make lint`**: Runs `golangci-lint` (v2.10.1) across the codebase. 
    *   This is configured via `.golangci.yml` and is a strict requirement in CI.
    *   The command automatically uses `go run github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.10.1 run` to ensure you are using the exact same version of the linter as the CI pipeline, without needing to install it manually on your system.
    ```bash
    make lint
    ```

### The CI Pipeline Process

When you push code or open a Pull Request, GitHub Actions will trigger the `build.yml` workflow. Here is what happens in detail:

1.  **Environment Setup**: The pipeline sets up Go `1.26`.
2.  **Linting**: Runs `golangci-lint-action` using version `v2.10.1`. If the linter fails, the pipeline fails.
3.  **Dependency Fetching**: Runs `make deps`.
4.  **Testing**: Runs `make test`.
5.  **Compilation**: Runs `make build`.
6.  **Docker Validation**: 
    *   A static analysis of the `build/docker/Dockerfile` is performed using `hadolint`.
    *   A test Docker image is built using `golang:1.26-alpine` as the builder.
    *   A smoke test is run (e.g., executing `--help` inside the built Alpine container).
    *   Trivy scans the image for `CRITICAL` or `HIGH` vulnerabilities.
7.  **Publishing**: Only if *all* of the above validations pass, the Docker artifacts are built for `amd64` and `arm64/v8` platforms and published to GHCR.

## Submitting Changes

1.  **Ensure CI passes locally**: Before committing, always run:
    ```bash
    make deps && make test && make lint && make build
    ```
2.  **Commit your changes**: Provide clear and concise commit messages.
3.  **Open a Pull Request**: Describe what you changed and why. If it fixes an open issue, reference it in the description.

## Bug Reports

If you have found a bug, please create an issue and indicate your operating system, platform, and the game on which the error was reproduced. Also, describe the exact steps you took so the error can be easily reproduced.
