#!/bin/bash
set -e

USERNAME="$1"

if [ -z "$USERNAME" ]; then
    echo "❌ Please provide your username as the first argument."
    echo "Usage: ./install.sh your_username"
    exit 1
fi

# Ensure pacman is up to date
sudo pacman -Syu --noconfirm

# Xorg + Drivers + Terminal + Fonts
sudo pacman -S --noconfirm \
    xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xterm \
    xorg-xprop xorg-xev xorg-xkill \
    xf86-video-intel mesa brightnessctl pulseaudio \
    ttf-dejavu \
    i3-wm i3status i3lock dmenu rofi picom alacritty firefox vim fastfetch

# Setup .xinitrc
cat <<EOF > ~/.xinitrc
pulseaudio --start &
exec i3
EOF

# Setup .bash_profile to autostart X
touch ~/.bash_profile
if ! grep -q 'exec startx' ~/.bash_profile; then
    echo '[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx' >> ~/.bash_profile
fi

# Copy dotfiles
mkdir -p ~/.config/alacritty ~/.config/i3 ~/.config/i3status ~/.config/picom ~/.config/rofi ~/.config/rofi/themes

mkdir -p ~/.config/alacritty/themes/alacritty-theme/themes
cp configs/alacritty/themes/alacritty-theme/themes/night_owl.toml ~/.config/alacritty/themes/alacritty-theme/themes/night_owl.toml

cp configs/alacritty/alacritty.toml         ~/.config/alacritty/alacritty.toml
cp configs/i3/config                        ~/.config/i3/config
cp configs/i3status/config                  ~/.config/i3status/config
cp configs/picom/picom.conf                 ~/.config/picom/picom.conf
cp configs/rofi/config.rasi                 ~/.config/rofi/config.rasi
cp configs/rofi/themes/thinkpad.rasi        ~/.config/rofi/themes/thinkpad.rasi
cp bash/bashrc                              ~/.bashrc

# Hide unwanted apps from Rofi
sudo find /usr/share/applications -iname '*rofi*' -exec sudo sed -i 's/^NoDisplay=false/NoDisplay=true/' {} \;
sudo find /usr/share/applications -iname '*picom*' -exec sudo sed -i 's/^NoDisplay=false/NoDisplay=true/' {} \;

# Setup visudo permissions (interactive)
if ! sudo grep -q '/usr/bin/tee' /etc/sudoers; then
    echo "⚠️ Manual Step: Add this to visudo (run 'sudo visudo') if not already present:"
    echo "$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/tee"
fi

echo "✅ Setup complete. Run 'startx' or reboot to launch i3."