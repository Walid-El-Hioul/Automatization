# Windows Setup Scripts

This repository contains a set of PowerShell and Bash scripts to automate the setup and installation process for various applications, tools, and dependencies on Windows systems. The scripts ensure a consistent and streamlined setup across multiple machines, saving time and effort.

## Main Script: Apps.ps1

The `Apps.ps1` script is the primary PowerShell script that performs the following tasks:

1. **Install Chocolatey**: If Chocolatey (a popular package manager for Windows) is not already installed, it will be installed.

2. **Install Windows Subsystem for Linux (WSL)**: If WSL is not installed, it will be enabled along with the required features for running WSL 2.

3. **Install Ubuntu on WSL**: If the Ubuntu distribution is not installed on WSL, it will be installed using Chocolatey.

4. **Install Applications**: The script installs a predefined list of applications using Chocolatey. The list includes popular applications like Google Chrome, Visual Studio Code, Zoom, Discord, and many others.

5. **Install Python Dependencies**: The script installs a set of Python dependencies using pip. These dependencies include libraries for packet manipulation, machine learning, data analysis, visualization, and web development.

6. **Install Additional Applications**: The script prompts the user to enter additional applications they want to install. These applications are then installed using Chocolatey.

7. **Upgrade Installed Packages**: After installing all the applications, the script upgrades all installed Chocolatey packages to their latest versions.

8. **Output Logging**: The script captures all output and errors in separate log files (`output.log` and `errors.log`) for easy troubleshooting and reference.

## Bash Scripts

The repository includes two Bash scripts:

<<<<<<< HEAD
1. **push_data.sh**: This script copies application data folders from a source directory to a destination directory. It ensures that the destination directory exists and creates it if necessary.

2. **fetch_data.sh**: This script copies application data from a source directory to the corresponding application folders in a destination directory. It checks if the application folders exist in the destination directory before copying the data.
=======
1. **pull_data.sh**: This script copies application data folders from a source directory (PC) to a destination directory (Storage). It ensures that the destination directory exists.

2. **push_data.sh**: This script replace application data from a source directory (Storage) to the corresponding application folders in a destination directory (PC). It checks if the application folders exist in the destination directory before copying the data.
>>>>>>> origin/test

## Usage

1. Clone or download the repository to your Windows machine.
2. Open PowerShell as an administrator.
3. Navigate to the repository directory.
<<<<<<< HEAD
4. Run the `Apps.ps1` script by executing `.\Apps.ps1`.
=======
4. Run the `run.ps1` script by executing `.\run.ps1`.
>>>>>>> origin/test
5. Follow the prompts to install additional applications, if desired.
6. The script will install the specified applications, tools, and dependencies.
7. Check the `output.log` and `errors.log` files for any output or errors.

## Customization

You can customize the scripts according to your specific requirements:

- Modify the `$applications` array in `Apps.ps1` to add or remove applications to be installed.
- Update the `$dependencies` array in `Apps.ps1` to include or exclude Python dependencies.
- Adjust the paths or arguments in the Bash scripts (`push_data.sh` and `fetch_data.sh`) to match your file system structure.ssss

## Notes

- The scripts require an internet connection to download and install packages.
- Administrator privileges are required to run the scripts and install applications.
- Some applications or dependencies may require additional configuration or setup steps after installation.

Feel free to contribute to this repository by submitting bug reports, feature requests, or pull requests.

# License

<<<<<<< HEAD
This project is licensed under the [MIT License](LICENSE).
=======
This project is licensed under the [MIT License](LICENSE).
>>>>>>> origin/test
