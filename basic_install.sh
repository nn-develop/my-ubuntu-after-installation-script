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
    remmina

# Install Joplin (using AppImage as it's not available in the default Ubuntu repositories)
echo "Installing Joplin..."
sudo snap install joplin-desktop

# Install development tools: Git, Docker, Visual Studio Code, Postman
echo "Installing development tools..."
sudo apt install -y git docker.io docker-compose
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
code --install-extension oliversen.chatgpt-docstrings

# Enable and start Docker service
echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Fix suspend problem on my notebook (due to hybrid graphics card - Intel + Nvidia)
echo "Installing TLP for power management..."
sudo apt install -y tlp tlp-rdw
sudo systemctl enable tlp
sudo tlp start

# Modify /etc/systemd/logind.conf to use suspend instead of hibernation
echo "Configuring suspend settings..."
sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=suspend/' /etc/systemd/logind.conf
sudo sed -i 's/^#HandleLidSwitchDocked=suspend/HandleLidSwitchDocked=suspend/' /etc/systemd/logind.conf

# Clean up unnecessary packages
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y

# Done
echo "Installation and setup complete!"

