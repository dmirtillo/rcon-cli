## ADDED Requirements

### Requirement: Dockerfile Linting
The CI pipeline SHALL perform static analysis of the `Dockerfile` to ensure adherence to best practices and security standards.

#### Scenario: Dockerfile has lint errors
- **WHEN** a PR is opened or code is pushed
- **THEN** the `lint-dockerfile` step fails and stops the pipeline

### Requirement: Image Runtime Verification
The CI pipeline SHALL verify that the built Docker image can successfully execute the `gorcon` binary.

#### Scenario: Binary fails to boot in Alpine
- **WHEN** the image is built and run with the `--help` flag
- **THEN** the exit code is non-zero and the pipeline fails

### Requirement: Vulnerability Scanning
The CI pipeline SHALL scan the final Docker image for known security vulnerabilities.

#### Scenario: Critical vulnerability detected
- **WHEN** Trivy scans the image
- **THEN** if vulnerabilities with severity `CRITICAL` or `HIGH` are found, the pipeline fails

### Requirement: Atomic Publish
The CI pipeline SHALL only push images to the registry if all validation steps (lint, smoke test, security scan) have passed.

#### Scenario: Smoke test fails
- **WHEN** the runtime verification fails
- **THEN** the subsequent `Build and publish` step is skipped or aborted
