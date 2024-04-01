#!/bin/sh
set -e

apt-get update && apt-get install -y curl 


releaseVersion=${RELEASEVERSION:-undefined}

echo "Installing cnoe-cli from release $releaseVersion'"

# For cnoe-cli AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -L https://github.com/cnoe-io/cnoe-cli/releases/download/$releaseVersion/cnoe_Linux_x86_64.tar.gz | tar xz cnoe
# For cnoe-cli ARM64
[ $(uname -m) = aarch64 ] && curl -L https://github.com/cnoe-io/cnoe-cli/releases/download/$releaseVersion/cnoe_Linux_arm64.tar.gz | tar xz cnoe
chmod +x ./cnoe
mv ./cnoe /usr/local/bin/cnoe
