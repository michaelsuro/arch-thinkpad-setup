#!/bin/bash

echo "📡 Installing Newsboat and copying config files..."

# Install newsboat
sudo pacman -S --noconfirm newsboat

# Create config directory if it doesn't exist
mkdir -p ~/.config/newsboat

# Copy configuration files
cp configs/newsboat/config ~/.config/newsboat/config
cp configs/newsboat/urls ~/.config/newsboat/urls

echo "✅ Newsboat installed and configured."