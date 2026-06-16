FROM docker.io/node:26-alpine

LABEL org.opencontainers.image.source=https://github.com/datf/copier-runner
LABEL org.opencontainers.image.description="Runner for copier"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_BREAK_SYSTEM_PACKAGES=1

RUN npm install --global npm@latest corepack@latest pnpm@latest
RUN apk add --update --no-cache python3 py3-pip git su-exec
RUN pip3 install --no-cache --upgrade pip setuptools copier

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]

CMD ["--version"]
