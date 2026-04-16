#!/bin/sh
set -e

apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

VERSION=${VERSION:-latest}
INSTALLTCTL=${INSTALLTCTL:-true}

if [ "$VERSION" = "latest" ]; then
    VERSION=$(curl --proto '=https' --tlsv1.2 -fsSL \
        --retry 5 --retry-all-errors --retry-delay 2 \
        --connect-timeout 10 --max-time 60 \
        -I -o /dev/null -w '%{url_effective}' \
        https://github.com/gravitational/teleport/releases/latest \
        | grep -o '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$')
fi

[ -z "$VERSION" ] && { echo "Failed to resolve Teleport version"; exit 1; }
echo "$VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$' || { echo "Invalid version format: $VERSION"; exit 1; }

echo "Installing Teleport v${VERSION}"

ARCH=$(uname -m)
case "$ARCH" in
    x86_64)  ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

TARBALL="teleport-v${VERSION}-linux-${ARCH}-bin.tar.gz"
BASE_URL="https://cdn.teleport.dev"

trap 'rm -f "$TARBALL" "${TARBALL}.sha256"; rm -rf teleport/' EXIT

curl --proto '=https' --tlsv1.2 -fsSL \
    --retry 5 --retry-all-errors --retry-delay 2 \
    --connect-timeout 10 --max-time 120 \
    -o "$TARBALL" "${BASE_URL}/${TARBALL}"
curl --proto '=https' --tlsv1.2 -fsSL \
    --retry 5 --retry-all-errors --retry-delay 2 \
    --connect-timeout 10 --max-time 60 \
    -o "${TARBALL}.sha256" "${BASE_URL}/${TARBALL}.sha256"

EXPECTED=$(awk '{print $1}' "${TARBALL}.sha256")
echo "${EXPECTED}  ${TARBALL}" | sha256sum --check

BINARIES="teleport/tsh"
if [ "$INSTALLTCTL" = "true" ]; then
    BINARIES="$BINARIES teleport/tctl"
fi

# shellcheck disable=SC2086
tar xzf "$TARBALL" $BINARIES

chmod +x teleport/tsh
mv teleport/tsh /usr/local/bin/tsh

if [ "$INSTALLTCTL" = "true" ]; then
    chmod +x teleport/tctl
    mv teleport/tctl /usr/local/bin/tctl
fi
