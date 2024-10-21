# Ubuntu After Installation Script

This script automates the post-installation setup for Ubuntu, making it quick and easy to get your system ready for development, creative work, and daily use. It installs essential software, development tools, configures power management for hybrid graphics, and ensures your system is clean and optimized.

## Features

- **System Update**: Updates all system packages to the latest versions.
- **Essential Software**: Installs commonly used applications such as:
  - GIMP (image editing)
  - Inkscape (vector graphics)
  - Scribus (desktop publishing)
  - PDF Arranger (PDF manipulation)
  - Remmina (remote desktop client)
  - Joplin (note-taking, using Snap)
- **Development Tools**: Sets up a development environment with:
  - Git (version control)
  - Docker and Docker Compose (containerization tools)
  - Visual Studio Code (code editor, using Snap) with useful extensions
  - Postman (API development, using Snap)
  - Draw.io (diagramming tool, using Snap)
- **Power Management Optimization**: Installs and configures TLP to enhance battery performance and addresses suspend issues on laptops with hybrid Intel + Nvidia graphics.
- **System Cleanup**: Automatically removes unnecessary packages to free up disk space and improve performance.

## Installation

To use this script, follow these steps:

1. Clone the repository:
  ```bash
  git clone https://github.com/nn-develop/my-ubuntu-after-installation-script.git
  ```

  Navigate to the cloned directory:

  ```bash
  cd <script-directory>
  ```

  Make the script executable:

  ```bash
  chmod +x post_install_script.sh
  ```

  Run the script:

  ```bash
  ./post_install_script.sh
  ```

## Customization

You can modify the script to suit your personal needs by adding or removing applications or making additional configuration changes. Simply edit the script and adjust the installation commands as needed.

## Notes

This script is optimized for Ubuntu systems, but it may work on other Debian-based distributions with minor modifications.
For laptops with hybrid graphics (Intel + Nvidia), this script includes a fix for suspend issues by configuring TLP and adjusting power settings.

## Contributions

Feel free to submit issues or pull requests if you'd like to improve the script or suggest new features.