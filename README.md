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
- **Power Management Optimization**: Fixes black screen issue after hibernation by modifying kernel parameters for i915
- **System Cleanup**: Automatically removes unnecessary packages to free up disk space and improve performance.

## Installation

To use this script, follow these steps:

1. Clone the repository:

    ```bash
    git clone https://github.com/nn-develop/my-ubuntu-after-installation-script.git
    ```

2. Navigate to the cloned directory:

    ```bash
    cd <script-directory>
    ```

3. Make the script executable:

    ```bash
    chmod +x post_install_script.sh
    ```

4. Adjust script to your system:

    4.1. Find the UUID of your swap partition:

        ```bash
        sudo blkid | grep swap
        ```

    4.2. The script modifies the GRUB configuration to include the swap partition's UUID, which is required for proper hibernation functionality. You need to replace the UUID `UUID=d6feb52c-2bb7-41eb-807b-7723aff1c7f5` with your actual swap partition UUID in the following line:

        ```bash
        sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i915.enable_psr=0 resume=UUID=your-uuid-here"/' /etc/default/grub
        ```

5. Run the script:

    ```bash
    ./post_install_script.sh
    ```

6. Reboot the system after the script completes.

## Customization

You can modify the script to suit your personal needs by adding or removing applications or making additional configuration changes. Simply edit the script and adjust the installation commands as needed.

## Notes

This script is optimized for Ubuntu systems, but it may work on other Debian-based distributions with minor modifications.
For many laptops with Intel integrated graphics, this script includes a fix for black screen issues after hibernation.

## Contributions

Feel free to submit issues or pull requests if you'd like to improve the script or suggest new features.