#!/bin/sh

# Ignore OS version mismatch (pfSense requirement)
export IGNORE_OSVERSION=yes

# Detect architecture
ARCH=$(uname -m | sed -e "s/amd64/x86_64/" -e "s/arm64/aarch64/")

# Temp working directory
WORKDIR="/tmp/netbird-update"
mkdir -p "$WORKDIR"
cd "$WORKDIR" || exit 1

# Get download URLs for this architecture
URLS=$(curl -s https://api.github.com/repos/netbirdio/pfsense-netbird/releases/latest \
       | jq -r ".assets[].browser_download_url" \
       | grep "$ARCH")

# Download packages
for URL in $URLS; do
    curl -L -O "$URL" || exit 1
done

# Install packages (force upgrade)
pkg-static add -f netbird-*.pkg || exit 1
pkg-static add -f pfSense-pkg-NetBird-*.pkg || exit 1

# Cleanup downloaded packages
rm -f netbird-*.pkg pfSense-pkg-NetBird-*.pkg

# Restart NetBird safely in background
(sleep 2; service netbird restart) &

exit 0
