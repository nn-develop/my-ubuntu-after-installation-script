#!/bin/bash
set -euo pipefail

# Update the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install basic programs
echo "Installing basic programs..."
sudo apt install -y \
    gimp \
    inkscape \
    scribus \
    pdfarranger \
    thunderbird \
    xournalpp \
    epodpisfs \
    proton-authenticator \
    meld

# Install Joplin (using AppImage as it's not available in the default Ubuntu repositories)
echo "Installing Joplin..."
sudo snap install joplin-desktop

# Install LibreOffice (using snap)
echo "Installing LibreOffice..."
sudo snap install libreoffice

# Install Brave browser (snap provides automatic updates)
echo "Installing Brave browser..."
sudo snap install brave

# Install development tools: Git, Docker, Visual Studio Code, Postman
echo "Installing development tools..."
sudo apt install -y git docker.io docker-compose-v2 docker-buildx
sudo snap install drawio

# Add the current user to the Docker group to avoid needing 'sudo' for Docker commands
sudo usermod -aG docker "$USER"

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo snap install code --classic

# Install Postman
echo "Installing Postman..."
sudo snap install postman

# Install VS Code extensions
echo "Installing Visual Studio Code extensions..."
code --install-extension dracula-theme.theme-dracula || true
code --install-extension ms-toolsai.jupyter || true
code --install-extension cweijan.vscode-mysql-client2 || true
code --install-extension ms-python.python || true
code --install-extension ms-python.black-formatter || true
code --install-extension eamodio.gitlens || true
code --install-extension github.codespaces || true
code --install-extension github.copilot || true
code --install-extension github.copilot-chat || true
code --install-extension njpwerner.autodocstring || true

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Force classic HDA driver and disable Intel DSP (for SF514-52TP audio)
echo "Configuring ALSA to force HDA driver (Intel DSP off)..."
sudo bash -c 'grep -qxF "options snd-intel-dspcfg dsp_driver=1" /etc/modprobe.d/alsa-base.conf || echo "options snd-intel-dspcfg dsp_driver=1" >> /etc/modprobe.d/alsa-base.conf'

# Safely extend GRUB cmdline without overwriting other params
GRUB_FILE="/etc/default/grub"
ensure_grub_param() {
    local param="$1"
    if ! grep -q "^GRUB_CMDLINE_LINUX_DEFAULT=" "$GRUB_FILE"; then
        echo "GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"" | sudo tee -a "$GRUB_FILE" >/dev/null
    fi
    if ! grep -q "GRUB_CMDLINE_LINUX_DEFAULT=\".*\b${param}\b.*\"" "$GRUB_FILE"; then
        sudo sed -i "s/^\(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*\)\"/\1 ${param}\"/" "$GRUB_FILE"
        echo "Added ${param} to GRUB_CMDLINE_LINUX_DEFAULT"
    else
        echo "${param} already present in GRUB_CMDLINE_LINUX_DEFAULT"
    fi
}

echo "Configuring Intel i915 kernel parameters (PSR off, DC off for suspend)..."
ensure_grub_param "i915.enable_psr=0"
ensure_grub_param "i915.enable_dc=0"

if [[ -n "${MEM_SLEEP_DEFAULT:-}" ]]; then
    echo "Setting mem_sleep_default=${MEM_SLEEP_DEFAULT} (override via MEM_SLEEP_DEFAULT env var)"
    ensure_grub_param "mem_sleep_default=${MEM_SLEEP_DEFAULT}"
fi

echo "Updating GRUB..."
sudo update-grub

# Clean up unnecessary packages
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

# Done
echo "Installation and setup complete!"

