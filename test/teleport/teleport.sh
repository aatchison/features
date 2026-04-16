#!/bin/bash
set -e

source dev-container-features-test-lib

check "tsh binary is installed and in path" bash -c "type -f /usr/local/bin/tsh"
check "tsh reports correct version" bash -c "tsh version | grep -qE '(^|[^0-9])18\.7\.2([^0-9]|$)'"
check "tctl binary is installed and in path" bash -c "type -f /usr/local/bin/tctl"
check "tctl reports correct version" bash -c "tctl version | grep -qE '(^|[^0-9])18\.7\.2([^0-9]|$)'"

reportResults
