# Start transcript to capture all output
Start-Transcript -Path "output.log"

try {
    # Execute the main script and redirect all errors to errors.log
    .\Apps.ps1 *>&1 | Tee-Object -FilePath "errors.log"
} catch {
    # If an error occurs, write the error message to errors.log
    $_ | Out-File -Append -FilePath "errors.log"
}

# Stop transcript
Stop-Transcript
