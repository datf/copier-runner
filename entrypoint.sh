#!/bin/sh

# Get the User ID and Group ID of the mounted /app folder
HOST_UID=$(stat -c "%u" /app)
HOST_GID=$(stat -c "%g" /app)

# If the mounted folder is not owned by root, run as a matched non-root user
if [ "$HOST_UID" -ne 0 ]; then
    # Alpine's syntax for creating a group and user
    addgroup -g "$HOST_GID" appgroup 2>/dev/null || true
    adduser -u "$HOST_UID" -G appgroup -h /home/appuser -D appuser 2>/dev/null || true

    # Drop privileges and run Copier as the matched user using su-exec
    export HOME=/home/appuser
    exec su-exec appuser copier "$@"
fi

# Fallback: run as root if no volume is mounted or if owned by root
exec copier "$@"
