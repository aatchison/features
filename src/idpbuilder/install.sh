#!/bin/sh
set -e

apt-get update && apt-get install -y curl 


releaseVersion=${RELEASEVERSION:-undefined}

echo "Installing idpbuilder from release $releaseVersion'"

# For idpbuilder AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -L https://github.com/cnoe-io/idpbuilder/releases/download/$releaseVersion/idpbuilder-linux-amd64.tar.gz | tar xz
# For idpbuilder ARM64
[ $(uname -m) = aarch64 ] && curl -L https://github.com/cnoe-io/idpbuilder/releases/download/$releaseVersion/idpbuilder-linux-arm64.tar.gz | tar xz
chmod +x ./idpbuilder
mv ./idpbuilder /usr/local/bin/idpbuilder
