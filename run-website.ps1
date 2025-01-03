# PowerShell script to run a .NET 4.7.2 website locally

    # Set variables
    $websitePath = $PSScriptRoot  # Use the script's directory as the website path
    $port = 8080                  # Port to use for the website
    $frameworkVersion = "v4.0"   # .NET Framework version directory name

    # Construct the path to the .NET Framework executable
    $frameworkPath = "C:\Windows\Microsoft.NET\Framework\$frameworkVersion\aspnet_wp.exe"

    # Check if the .NET Framework executable exists
    if (-not (Test-Path $frameworkPath)) {
        Write-Error "Error: .NET Framework executable not found at '$frameworkPath'. Please ensure .NET Framework 4.7.2 is installed."
        return
    }

    # Construct the command to run the website
    $command = "$frameworkPath -v /LM/W3SVC/1 -p $port -s $websitePath"

    # Display the command
    Write-Host "Running website with command: '$command'"

    # Start the website
    try {
        Start-Process -FilePath $frameworkPath -ArgumentList "-v /LM/W3SVC/1 -p $port -s $websitePath" -NoNewWindow
        Write-Host "Website started successfully on port $port."
    } catch {
        Write-Error "Error starting website: $_"
    }

    # Keep the script running
    Write-Host "Press any key to stop the website..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    # Stop the website
    try {
        Stop-Process -Name "aspnet_wp" -ErrorAction SilentlyContinue
        Write-Host "Website stopped."
    } catch {
        Write-Error "Error stopping website: $_"
    }
