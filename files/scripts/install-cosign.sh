#!/bin/bash
# hugely based on https://github.com/ublue-os/main/blob/main/build_files/github-release-install.sh

set -ouex pipefail

API_JSON=$(mktemp /tmp/api-XXXXXXXX.json)
API="https://api.github.com/repos/sigstore/cosign/releases/latest"

# retry up to 5 times with 5 second delays for any error included HTTP 404 etc
curl --fail --retry 5 --retry-delay 5 --retry-all-errors -sL ${API} -o ${API_JSON}
RPM_URLS=($(cat ${API_JSON} |
  jq \
    -r \
    --arg arch_filter "x86_64" \
    '.assets | sort_by(.created_at) | reverse | .[] | select(.name|test($arch_filter)) | select(.name|test("rpm$")) | .browser_download_url'))
# WARNING: in case of multiple matches, this only installs the first matched release
echo "execute: dnf5 -y install \"${RPM_URLS[0]}\""
dnf5 -y install "${RPM_URLS[0]}"
