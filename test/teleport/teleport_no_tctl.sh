#!/bin/bash
set -e

source dev-container-features-test-lib

check "tsh binary is installed and in path" bash -c "type -f /usr/local/bin/tsh"
check "tsh runs" bash -c "tsh version"
check "tctl is not installed" bash -c "! type -f /usr/local/bin/tctl"

reportResults
