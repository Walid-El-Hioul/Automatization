# Install Chocolatey if not already installed
if (-not (Test-Path "C:\ProgramData\chocolatey\choco.exe")) {
    Write-Output "Chocolatey is not installed. Installing Chocolatey..."
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install WSL if not already installed
if (-not (Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -eq "Enabled") {
    Write-Output "WSL is not installed. Installing WSL..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
}

# Install WSL 2 if not already installed
if (-not (Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform).State -eq "Enabled") {
    Write-Output "WSL 2 is not installed. Installing WSL 2..."
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
}

# Set WSL 2 as the default version
wsl --set-default-version 2

# Download and install the latest WSL kernel update
Write-Output "Installing the latest WSL kernel update..."
Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "$env:TEMP\wsl_update_x64.msi"
Start-Process msiexec.exe -ArgumentList "/i `"$env:TEMP\wsl_update_x64.msi`" /quiet /norestart" -NoNewWindow -Wait

# Install a Linux distribution (e.g., Ubuntu) if not already installed
if (-not (wsl -l -q | Select-String -Pattern "Ubuntu")) {
    Write-Output "Installing Ubuntu..."
    Invoke-Expression "choco install -y wsl-ubuntu-2004"
}

# List of applications to install
$applications = @(
    # Browsers
    "brave"

    # Media Players
    "vlc"

    # Development Tools
    "vscode"
    "git.install"
    "nodejs-lts"
    "python3"
    "mysql"
    "mysql.workbench"
    "postman"
    "github"
    "mongodb.compass"
    "packettracer"

    # Communication Tools
    "zoom"
    "discord"
    "microsoftteams"

    # Text Editors and IDEs
    "notepadplusplus"

    # PDF and Document Tools
    "adobereader"

    # Remote Access and File Transfer
    "winscp"
    "putty.install"
    "putty.portable"

    # Download Managers
    "freedownloadmanager"

    # Cloud Storage
    "googledrive"
    "onedrive"

    # Security and Privacy Tools
    "malwarebytes"
    "openvpn"
    "nextdns"

    # Networking Tools
    "wireshark"
    "npcap"
    "advanced-ip-scanner"

    # System Utilities
    "javaruntime"
    "microsoft.netfx"
    "oracle-vm-virtualbox"
    "revouninstaller"
    "speedtest"
    "wisefolderhider"
    "visualcpp-build-tools"
    "cpu-z"
    "7zip"
    "easeus-todo-backup"
    "docker-desktop"

    # Office Suite
    "microsoft-365"
    "microsoft-office"
    "microsoft-loop"
)


# Install applications using Chocolatey
foreach ($app in $applications) {
    if (-not (Get-Command $app -ErrorAction SilentlyContinue)) {
        Write-Output "Installing $app using Chocolatey..."
        choco install $app -y
    } else {
        Write-Output "$app is already installed."
    }
}

# ************************** USER ****************************
# New list for user-inputted apps
$new_apps = @()

# Prompt user for additional apps
do {
    $input_app = Read-Host "Enter an app you want to install (or enter 'done' to finish):"
    if ($input_app -ne "done") {
        $new_apps += $input_app
    }
} until ($input_app -eq "done")

# Install new applications using Chocolatey
foreach ($napp in $new_apps) {
    if (-not (Get-Command $napp -ErrorAction SilentlyContinue)) {
        Write-Output "Installing $napp using Chocolatey..."
        choco install $napp -y
    } else {
        Write-Output "$napp is already installed."
    }
}
# ********************************************************************

# Upgrade all installed Chocolatey packages to the latest versions
Write-Output "Upgrading all installed Chocolatey packages to the latest versions..."
choco upgrade all -y

Write-Output "All new applications installed successfully."

Write-Output "All tasks completed successfully."
