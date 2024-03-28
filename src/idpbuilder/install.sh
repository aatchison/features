#!/bin/sh
set -e

releaseVersion=${releaseVersion:-undefined}

echo "Installing idpbuilder from release $releaseVersion'"

# For Kubectl AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -L https://github.com/cnoe-io/idpbuilder/releases/download/v0.3.0/idpbuilder-linux-${releaseVersion}.tar.gz | tar xz
# For Kubectl ARM64
[ $(uname -m) = aarch64 ] && curl -L https://github.com/cnoe-io/idpbuilder/releases/download/v0.3.0/idpbuilder-linux-${releaseVersion}.tar.gz | tar xz
chmod +x ./idpbuilder
sudo mv ./idpbuilder /usr/local/bin/idpbuilder
