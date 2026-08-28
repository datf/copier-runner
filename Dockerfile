FROM docker.io/node:26-alpine

LABEL org.opencontainers.image.source=https://github.com/datf/copier-runner
LABEL org.opencontainers.image.description="Runner for copier"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0

# renovate: datasource=npm depName=npm
ENV NPM_VERSION="12.0.2"
# renovate: datasource=npm depName=corepack
ENV COREPACK_VERSION="0.36.0"
# renovate: datasource=npm depName=pnpm
ENV PNPM_VERSION="11.24.0"
RUN npm install --global npm@$NPM_VERSION corepack@$COREPACK_VERSION \
    && corepack enable \
    && corepack prepare pnpm@$PNPM_VERSION --activate

# renovate: datasource=repology depName=alpine_3_24/python3 versioning=loose
ENV PYTHON3_VERSION="3.14.7-r1"
# renovate: datasource=repology depName=alpine_3_24/py3-pip versioning=loose
ENV PIP_APK_VERSION="26.1.2-r0"
# renovate: datasource=repology depName=alpine_3_24/git versioning=loose
ENV GIT_APK_VERSION="2.54.0-r0"
# renovate: datasource=repology depName=alpine_3_24/su-exec versioning=loose
ENV SU_EXEC_APK_VERSION="0.3-r0"
RUN apk add --update --no-cache \
    python3=$PYTHON3_VERSION \
    py3-pip=$PIP_APK_VERSION \
    git=$GIT_APK_VERSION \
    su-exec=$SU_EXEC_APK_VERSION

# renovate: datasource=pypi depName=pip
ENV PIP_VERSION="26.2.1"
# renovate: datasource=pypi depName=setuptools
ENV SETUPTOOLS_VERSION="84.0.0"
# renovate: datasource=pypi depName=copier
ENV COPIER_VERSION="9.17.2"
RUN pip3 install --no-cache --upgrade \
    pip==$PIP_VERSION \
    setuptools==$SETUPTOOLS_VERSION \
    copier==$COPIER_VERSION

WORKDIR /app
USER node

ENTRYPOINT ["copier"]
CMD ["--version"]
