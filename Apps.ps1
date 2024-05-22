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
    "googlechrome"
    "vlc"
    "vscode"
    "zoom"
    "discord"
    "notepadplusplus"
    "adobereader"
    "teamviewer"
    "winscp"
    "putty.install"
    "git.install"
    "freedownloadmanager"
    "github.install"
    "googledrive"
    "javaruntime"
    "malwarebytes"
    "microsoft.netfx"
    "microsoft-office-deployment"
    "onedrive"
    "microsoftteams"
    "mongodb.compass"
    "msys2"
    "mysql"
    "mysql.workbench"
    "nodejs-lts"
    "notion-enhancer"
    "npcap"
    "opendns-updater"
    "openvpn"
    "oracle-vm-virtualbox"
    "postman"
    "poweriso"
    "putty.portable"
    "python3"
    "revouninstaller"
    "speedtest"
    "kb5000716"
    "visualstudio2022buildtools"
    "visualstudio2022community"
    "windows11installassistant"
    "windowsadkwindows10"
    "wireshark"
    "wisefolderhider"
    "vcredist2015"
    "vcredist2017"
    "java"
    "visualcpp-build-tools"
    "windows-sdk"
    # Add more applications as needed
)

# List of dependencies to install
$dependencies = @(
    "scapy",           # Packet manipulation and network traffic analysis
    "pyshark",         # Wrapper for TShark for packet capture and parsing
    "dpkt",            # Fast, simple packet creation and parsing
    "scikit-learn",    # Classical machine learning algorithms
    "tensorflow",      # Deep learning framework (choose one: TensorFlow or PyTorch)
    "keras",           # High-level neural networks API (if using TensorFlow)
    "xgboost",         # Gradient boosting algorithms
    "pandas",          # Data manipulation and analysis
    "numpy",           # Numerical operations
    "dask",            # Parallel computing and handling large datasets
    "matplotlib",      # Plotting and visualization
    "seaborn",         # Statistical data visualization
    "plotly",          # Interactive visualizations
    "notebook",        # Interactive coding and visualization
    "tqdm",            # Progress bars
    "configparser",    # Handling configuration files
    "sqlalchemy",      # Database interactions
    "requests",        # Making HTTP requests
    "flask",           # Web interface development (choose one: Flask or Django)
    "yara-python",     # Malware identification
    "pyclamd"          # Virus scanning using ClamAV
    # Add more dependencies as needed
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
Write-Output "All applications installed successfully."

# Install Python dependencies using pip
foreach ($dep in $dependencies) {
    Write-Output "Installing dependency: $dep"
    pip install $dep
}
Write-Output "All dependencies installed successfully."

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

# Upgrade all installed Chocolatey packages to the latest versions
Write-Output "Upgrading all installed Chocolatey packages to the latest versions..."
choco upgrade all -y

Write-Output "All new applications installed successfully."

# # Run additional Bash scripts
# $bashScripts = @(
    #     "push_data.sh"
    #     # Add more scripts as needed
    # )

# foreach ($script in $bashScripts) {
    #     Write-Output "Executing Bash script: $script"
    #     wsl bash -c "bash $script"
    # }

Write-Output "All tasks completed successfully."
