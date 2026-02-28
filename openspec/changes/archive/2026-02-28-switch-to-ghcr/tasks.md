## 1. Update CI Pipeline Configuration

- [x] 1.1 Add `permissions` block to the `.github/workflows/build.yml` file granting `contents: read` and `packages: write`.
- [x] 1.2 Modify the `docker/login-action` step in `.github/workflows/build.yml` to authenticate against `ghcr.io` using `username: ${{ github.actor }}` and `password: ${{ secrets.GITHUB_TOKEN }}`.

## 2. Update Image Tagging

- [x] 2.1 Update the `tags` and `image-ref` (for trivy) fields in `.github/workflows/build.yml` from `outdead/rcon` to `ghcr.io/dmirtillo/rcon-cli`.
- [x] 2.2 Update the `scripts/docker/docker.mk` file to reflect the new GHCR tagging `ghcr.io/dmirtillo/rcon-cli` instead of `outdead/rcon`.
