# Arch ThinkPad i3 Setup

This repo contains everything required to recreate my minimalist ThinkPad Arch Linux + i3 window manager environment from a clean base Arch install.

---

## 📦 Packages Installed
The `install.sh` script installs:
- X11 + drivers (`xorg-server`, `xorg-xinit`, `xf86-video-intel`, `mesa`,`brightnessctl`, `pulseaudio`, etc)
- i3 window manager suite (`i3-wm`, `i3status`, `i3lock`, `dmenu`, `picom`)
- UI & terminal tools (`alacritty`, `rofi`, `firefox`, `vim`, `fastfetch`)
- Fonts: `ttf-dejavu`

It also configures:
- `.xinitrc` to autostart i3
- `.bash_profile` to launch X when logging into TTY1
- Dotfiles: i3, i3status, picom, rofi, alacritty
- Hides Rofi and Picom from the application menu 

---

## 💻 How to Use

From a base Arch install (with networking configured), logged in as a normal user (not root):
```bash
# Clone this repo
git clone https://github.com/michaelsuro/arch-thinkpad-setup.git
cd arch-thinkpad-setup

# Make script executable and run it
# Replace with your actual username
chmod +x scripts/install.sh
./scripts/install.sh {your_username}
```

After completion, either run:
```bash
startx
```
or reboot the machine to automatically launch i3 from TTY1.

---

## ✍️ Manual Post-Install Tasks

These are not handled in the script but should be completed manually:

### 1. Visudo Rule for Tee (no password prompt)
Run:
```bash
sudo visudo
```
Then add this line at the bottom (replace with your actual username):

{your_username} ALL=(ALL) NOPASSWD: /usr/bin/tee

### 2. Delete rofi-theme-selector
Check if it exists:
```bash
grep -ril "Rofi theme selector" /usr/share/applications ~/.local/share/applications
```
Then remove it:
```bash
sudo rm /usr/share/applications/rofi-theme-selector.desktop
```

### 3. Customize Firefox
Run Firefox once to generate the profile folder. Then close Firefox and run:
```bash
chmod +x scripts/firefox-setup.sh
./scripts/firefox-setup.sh
```
This script will:
- Set Firefox as the default browser
- Apply dark mode and hardened privacy settings via user.js

---

## 🗂️ Directory Structure
```
arch-thinkpad-setup/
├── scripts/
│   ├── install.sh
│   ├── firefox-setup.sh
├── configs/
│   ├── alacritty/themes/alacritty-theme/themes/night_owl.toml
│   ├── alacritty/alacritty.toml
│   ├── i3/config
│   ├── i3status/config
│   ├── picom/picom.conf
│   ├── rofi/config.rasi
│   └── rofi/themes/thinkpad.rasi
└──bash/
    └── bashrc
```

