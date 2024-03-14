# Define parameters
$ExcludedProcesses = @("explorer.exe", "svchost.exe", "lsass.exe", "chrome.exe", "nvcontainer.exe", "nvidia*") # Add any trusted processes here

# Define ANSI escape sequences for green color
$Green = [char]27 + '[32m'
$ResetColor = [char]27 + '[0m'

# Function to detect reverse shell
function DetectReverseShell {
    $connections = Get-NetTCPConnection -State Established
    foreach ($connection in $connections) {
        $remotePort = $connection.RemotePort
        $remoteIP = $connection.RemoteAddress
        $processId = $connection.OwningProcess
        $process = Get-Process -Id $processId -ErrorAction SilentlyContinue
        if ($process -eq $null) {
            $processName = "(Unknown)"
        } else {
            $processName = $process.ProcessName
        }
        Write-Host "${Green}Connection detected to $remoteIP on port $remotePort${ResetColor}"
        Write-Host "${Green}Process ID: $processId${ResetColor}"
        Write-Host "${Green}Process Name: $processName${ResetColor}"
        Write-Host "${Green}-----------------------------------------${ResetColor}"
        if ($ExcludedProcesses -notcontains $processName) {
            # Check if the remote IP is a private IP or localhost
            if ($remoteIP -match '^127\.|^10\.|^192\.168\.' -or $remoteIP -eq '::1' -or $remoteIP -eq 'localhost') {
                Write-Host "${Green}Suspicious connection detected from a private IP or localhost.${ResetColor}"
                Write-Host "${Green}!!! Possible Reverse Shell Detected !!!${ResetColor}"
            } else {
                Write-Host "${Green}Connection from public IP.${ResetColor}"
            }
        }
    }
}

# Function to kill a process by ID
function KillProcessById {
    Start-Process -FilePath "process_killer.bat"
}

# Function to display the menu
function ShowMenu {
    Write-Host "${Green}Welcome to Reverse Shell Detector${ResetColor}"
    Write-Host "${Green}1. Detect Reverse Shell${ResetColor}"
    Write-Host "${Green}2. Kill Process${ResetColor}"
    Write-Host "${Green}3. Exit${ResetColor}"

    $choice = Read-Host "${Green}Select an action (1, 2, or 3): ${ResetColor}"

    switch ($choice) {
        '1' {
            DetectReverseShell
            ShowMenu
        }
        '2' {
            KillProcessById
            ShowMenu
        }
        '3' {
            # Exit the script
            exit
        }
        default {
            Write-Host "${Green}Invalid choice. Please select again.${ResetColor}"
            ShowMenu
        }
    }
}

# Show the menu
ShowMenu
