# NetBird-PFSense Client Update
scripts to update PFSense client for NetBird<br>
<br>
CURRENTLY ONLY VERIFIED TO WORK ON FREEBSD 15 due to NetBird waiting for official package to be approved by NetGate<br>
<br>
Currently verified with:<br>
PFSens Plus 25.07 - 25.11.1 (will work CE versions as well)<br>
<br>
cli command can be used for quick deploy single instances<br>
sh file can be used with cron jobs<br>
<br>
One Liner to manually install:<br>
<br>
sh -c 'export IGNORE_OSVERSION=yes; ARCH=$(uname -m | sed -e "s/amd64/x86_64/" -e "s/arm64/aarch64/"); curl -s https://api.github.com/repos/netbirdio/pfsense-netbird/releases/latest | jq -r ".assets[].browser_download_url" | grep "$ARCH" | xargs -n1 curl -L -O && pkg-static add -f netbird-*.pkg && pkg-static add -f pfSense-pkg-NetBird-*.pkg && rm -f netbird-*.pkg pfSense-pkg-NetBird-*.pkg && (sleep 2; service netbird restart) &'<br>
<br>
<br>
Whether you install via the command above or download and run the .sh file, the latest file will be pulled from NetBirds PFSense repo, installed and service restarted.<br>
