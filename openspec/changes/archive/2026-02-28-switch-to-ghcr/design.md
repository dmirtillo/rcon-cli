## Context

The repository is a fork located at `dmirtillo/rcon-cli`. The upstream project pushes Docker artifacts to Docker Hub under the `outdead/rcon` namespace, relying on an external repository secret (`GORCON_DOCKER_TOKEN`). To enable the CI pipeline in the fork without requiring manual setup of external secrets, we are migrating the Docker publish target to GitHub Container Registry (GHCR). GHCR can be authenticated against using the automatically provided `GITHUB_TOKEN`.

## Goals / Non-Goals

**Goals:**
- Authenticate to `ghcr.io` in the CI pipeline using `secrets.GITHUB_TOKEN`.
- Publish Docker images to `ghcr.io/dmirtillo/rcon-cli`.
- Ensure the workflow has the necessary `packages: write` permissions.

**Non-Goals:**
- Completely removing the ability to publish to Docker Hub if secrets are provided (we are replacing it, not making it conditionally support both).
- Renaming the binary itself.

## Decisions

- **Registry Target**: Use `ghcr.io`. 
  *Rationale*: Native integration with GitHub Actions, no external setup required.
- **Authentication**: Use `github.actor` and `secrets.GITHUB_TOKEN` in the `docker/login-action`. 
  *Rationale*: Secure, zero-configuration authentication provided by GitHub Actions.
- **Image Tagging**: Change `outdead/rcon` to `ghcr.io/dmirtillo/rcon-cli` across the pipeline. 
  *Rationale*: Required format for pushing to GHCR under the specific user's namespace.
- **Permissions**: Add explicit `permissions` block to the job or workflow.
  *Rationale*: Modern GitHub Actions require explicit permission grants to write to the `packages` scope when using the default token.

## Risks / Trade-offs

- **Risk**: Existing users or scripts downloading `outdead/rcon` will not see updates from this fork.
  *Mitigation*: This is expected behavior for a fork. Users of the fork will be instructed to pull from `ghcr.io/dmirtillo/rcon-cli`.
- **Trade-off**: Hardcoding `dmirtillo` in the tags.
  *Mitigation*: We could use `${{ github.repository_owner }}` to make it completely dynamic, but since the requirement specified `dmirtillo/rcon-cli`, explicit tagging is acceptable. We will use `ghcr.io/${{ github.repository_owner }}/rcon-cli` to be slightly more robust.
