## Context

Currently, dependency updates are manual, and there is a version mismatch for the Go compiler across the project (`go.mod` uses 1.21, Actions uses 1.21.6, Docker uses 1.19.3). This mismatch can cause CI or local build failures. We want to automate dependency updates with Dependabot but avoid breaking the build with unexpected Go toolchain updates.

## Goals / Non-Goals

**Goals:**
- Automate tracking and updating of Go modules, GitHub Actions, and Docker base images.
- Group PRs to reduce noise (e.g., one PR for go modules, one for actions).
- Keep Go compiler version changes manual to ensure coordination between Docker, CI, and `go.mod`.
- Align existing Docker Go version with the current `go.mod` version (1.21).

**Non-Goals:**
- Updating the project to a newer Go version like 1.22+.
- Refactoring existing dependencies themselves.

## Decisions

- **Target Branch**: Dependabot will target `develop` instead of `master`. 
  *Rationale*: Allows testing updates thoroughly before they reach the main stable branch.
- **Ignore Go toolchain updates**: We will explicitly add an `ignore` block for the `go` dependency in the `gomod` ecosystem configuration. 
  *Rationale*: Prevents the `go.mod` `go` directive from being bumped independently of the Dockerfile and CI configurations, preventing build breakages.
- **Update Dockerfile base image**: Change `FROM golang:1.19.3-alpine` to `golang:1.21-alpine`.
  *Rationale*: Matches the `go 1.21` directive in `go.mod` and resolves the version discrepancy.

## Risks / Trade-offs

- **Risk:** Dependabot might open a PR with a broken dependency update. 
  *Mitigation*: Pointing to `develop` means CI will catch it before it reaches `master`. Grouping updates limits the total number of PRs to review.
- **Trade-off:** By ignoring Go toolchain updates, we must manually monitor and upgrade the Go compiler version. 
  *Mitigation*: This is an acceptable trade-off for build stability.
