# Reverse Shell Detector

This script is designed to detect potential reverse shell connections on Windows and Linux systems and provide options to handle them.

## Usage

### Windows

1. **Detection**: Run the PowerShell script (`reverse_shell_detector.ps1`) in PowerShell to detect established network connections and identify associated processes. If a suspicious connection is detected, it will be highlighted, and a warning will be displayed.

2. **Killing Processes**: If a potential reverse shell is detected, you have the option to kill the associated process by providing its ID.

3. **Excluding Processes**: Certain trusted processes are excluded from detection by default. Modify this list of excluded processes in the script according to your requirements.

### Linux

1. **Detection**: Run the Bash script (`reverse_shell_detector.sh`) in a terminal to detect established network connections and identify associated processes. If a suspicious connection is detected, it will be highlighted, and a warning will be displayed.

2. **Killing Processes**: If a potential reverse shell is detected, you have the option to kill the associated process by providing its ID.

3. **Excluding Processes**: Certain trusted processes are excluded from detection by default. Modify this list of excluded processes in the script according to your requirements.

## Instructions

### Windows

1. **Run Script**: Execute the PowerShell script (`reverse_shell_detector.ps1`) in PowerShell.

2. **Follow Menu**: Follow the on-screen instructions to detect reverse shells and take necessary actions.

### Linux

1. **Run Script**: Execute the Bash script (`reverse_shell_detector.sh`) in a terminal.

2. **Follow Menu**: Follow the on-screen instructions to detect reverse shells and take necessary actions.

## Parameters

- `ExcludedProcesses`: A list of trusted processes excluded from detection by default. Modify this list to include or exclude processes based on your requirements.

## Notes

- Ensure that you have appropriate permissions to execute PowerShell or Bash scripts and access network-related information.

- This script is provided as-is and may require customization to suit your specific environment and use case.

- Use caution when killing processes, as terminating critical system processes may have unintended consequences.

