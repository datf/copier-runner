FROM docker.io/node:26-alpine AS base

RUN npm install --global npm@latest corepack@latest pnpm@latest
RUN apk add --update --no-cache python3 py3-pip git
RUN pip3 install --break-system-packages --no-cache --upgrade pip setuptools copier

WORKDIR /app
RUN adduser -D appuser
USER appuser

CMD ["copier"]
