@echo off
    echo Running website...

    set websitePath=%~dp0
    set port=8080
    set frameworkVersion=v4.0.30319

    set frameworkPath=C:\Windows\Microsoft.NET\Framework\%frameworkVersion%\aspnet_wp.exe

    if not exist "%frameworkPath%" (
        echo Error: .NET Framework executable not found at "%frameworkPath%". Please ensure .NET Framework 4.0.30319 is installed.
        pause
        exit /b 1
    )

    echo Running website with command: "%frameworkPath%" -v /LM/W3SVC/1 -p %port% -s "%websitePath%"

    start "" "%frameworkPath%" -v /LM/W3SVC/1 -p %port% -s "%websitePath%"

    echo Website started successfully on port %port%.
    echo Press any key to stop the website...
    pause > nul

    taskkill /f /im aspnet_wp.exe
    echo Website stopped.
