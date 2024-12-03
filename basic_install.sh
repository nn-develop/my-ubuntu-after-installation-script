#!/bin/bash

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
    remmina \
    thunderbird \
    xournalpp

# Install Joplin (using AppImage as it's not available in the default Ubuntu repositories)
echo "Installing Joplin..."
sudo snap install joplin-desktop

# Install LibreOffice (using snap)
echo "Installing LibreOffice..."
sudo snap install libreoffice

# Install development tools: Git, Docker, Visual Studio Code, Postman
echo "Installing development tools..."
sudo apt install -y git docker.io docker-compose-v2 docker-buildx
sudo snap install drawio

# Add the current user to the Docker group to avoid needing 'sudo' for Docker commands
sudo usermod -aG docker $USER

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo snap install code --classic

# Install Postman
echo "Installing Postman..."
sudo snap install postman

# Install VS Code extensions
echo "Installing Visual Studio Code extensions..."
code --install-extension dracula-theme.theme-dracula
code --install-extension ms-toolsai.jupyter
code --install-extension cweijan.vscode-mysql-client2
code --install-extension ms-python.python
code --install-extension ms-python.black-formatter
code --install-extension eamodio.gitlens
code --install-extension github.copilot
code --install-extension njpwerner.autodocstring

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Modify kernel parameters for i915 to fix black screen issue after hibernation
echo "Modifying kernel parameters for i915 and hibernation..."
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.enable_psr=0 resume=UUID=d6feb52c-2bb7-41eb-807b-7723aff1c7f5"/' /etc/default/grub
sudo update-grub

# Clean up unnecessary packages
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

# Done
echo "Installation and setup complete!"

