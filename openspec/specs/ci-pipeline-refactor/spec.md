## ADDED Requirements

### Requirement: Granular CI Jobs
The CI pipeline SHALL define distinct, standalone jobs for linting, testing, and building the application to provide clear status reporting.

#### Scenario: Running the CI pipeline
- **WHEN** the CI pipeline triggers on a push or pull request
- **THEN** separate jobs named `Lint`, `Test`, and `Build` are executed and reported individually in the GitHub interface

### Requirement: Parallel CI Execution
The `Lint` and `Test` jobs SHALL run concurrently when the pipeline is triggered.

#### Scenario: CI pipeline triggered
- **WHEN** the workflow starts
- **THEN** both `Lint` and `Test` jobs begin executing simultaneously without waiting for each other
