#!/bin/sh
set -e

apt-get update && apt-get install -y curl 


releaseVersion=${RELEASEVERSION:-undefined}

echo "Installing idpbuilder from release $releaseVersion'"

# For cnoe-cli AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -L https://github.com/cnoe-io/cnoe-clireleases/download/$releaseVersion/cnoe_linux_amd64.tar.gz | tar xz
# For cnoe-cli ARM64
[ $(uname -m) = aarch64 ] && curl -L https://github.com/cnoe-io/cnoe-cli/releases/download/$releaseVersion/cnoe_linux_arm64.tar.gz | tar xz
chmod +x ./cnoe
mv ./cnoe /usr/local/bin/cnoe