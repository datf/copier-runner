FROM docker.io/node:26-alpine

LABEL org.opencontainers.image.source=https://github.com/datf/copier-runner
LABEL org.opencontainers.image.description="Runner for copier"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN npm install --global npm@latest corepack@latest pnpm@latest
RUN apk add --update --no-cache python3 py3-pip git
RUN pip3 install --break-system-packages --no-cache --upgrade pip setuptools copier

WORKDIR /app
RUN adduser -D appuser
USER appuser

ENTRYPOINT ["copier"]

CMD ["--version"]
