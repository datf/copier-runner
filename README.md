# copier-runner

Lightweight alpine-based docker container to run [copier](https://github.com/copier-org/copier).

### Features
- Based on official `node:26-alpine` image
- Contains nodejs, npm, pnpm, python3, pip3, git and copier.
- Runs as non-root user
- Default volume configuration persists results back to the host machine.

## Get started

```shell
# Pull container from github
docker pull ghcr.io/datf/copier-runner:latest

docker run -it copier-runner \
  copy gh:path/to/copier-template
```

## Build image locally

Clone [this repository](https://github.com/datf/copier-runner), then build and run the container using `docker compose`.

```shell
git clone https://github.com/datf/copier-runner

# Build the image
docker compose build

# Run copier
docker compose run --rm -it copier \
  copy gh:path/to/copier-template
```
