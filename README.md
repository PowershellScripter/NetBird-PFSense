# NetBird-PFSense Client Update
scripts to update PFSense client for NetBird

CURRENTLY ONLY VERIFIED TO WORK ON FREEBSD 15 due to NetBird waiting for official package to be approved by NetGate




One Liner to manually install:

sh -c 'export IGNORE_OSVERSION=yes; ARCH=$(uname -m | sed -e "s/amd64/x86_64/" -e "s/arm64/aarch64/"); curl -s https://api.github.com/repos/netbirdio/pfsense-netbird/releases/latest | jq -r ".assets[].browser_download_url" | grep "$ARCH" | xargs -n1 curl -L -O && pkg-static add -f netbird-*.pkg && pkg-static add -f pfSense-pkg-NetBird-*.pkg && rm -f netbird-*.pkg pfSense-pkg-NetBird-*.pkg && (sleep 2; service netbird restart) &'


Whether you install via the command above or download and run the .sh file, the latest file will be pulled from NetBirds PFSense repo, installed and service restarted. 
