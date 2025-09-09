#!/bin/bash

echo "🦊 Setting Firefox as default browser..."
sudo pacman -S --noconfirm xdg-utils
xdg-settings set default-web-browser firefox.desktop

echo "🔍 Searching for Firefox default profile..."
FIREFOX_PROFILE=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default-release" | head -n 1)

if [ -z "$FIREFOX_PROFILE" ]; then
  echo "❌ Firefox profile not found. Please launch Firefox once, then re-run this script."
  exit 1
fi

echo "✍️  Writing user.js to $FIREFOX_PROFILE"

cat <<EOF > "$FIREFOX_PROFILE/user.js"
// Enable dark mode
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("layout.css.prefers-color-scheme.content-override", 2); // 2 = dark

// Hardened privacy
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.firstparty.isolate", true);
user_pref("network.cookie.cookieBehavior", 1); // Block 3rd party
user_pref("dom.security.https_only_mode", true);
user_pref("webgl.disabled", true);
user_pref("media.peerconnection.enabled", false); // disables WebRTC

// Disable telemetry and studies
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.ping-centre.telemetry", false);

// Minimal UI tweaks
user_pref("browser.tabs.inTitlebar", 1); // removes extra title bar
EOF

echo "✅ Firefox configuration applied."