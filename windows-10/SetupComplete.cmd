cd %TEMP%

REM Remove bloatware
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/SquelchPlop/os-config/master/windows/bloatware_removal/apps_remove.ps1'))"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/SquelchPlop/os-config/master/windows/bloatware_removal/features_remove.ps1'))"

REM Install JumpCloud agent
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; Invoke-RestMethod -Method Get -URI https://raw.githubusercontent.com/TheJumpCloud/support/master/scripts/windows/InstallWindowsAgent.ps1 -OutFile InstallWindowsAgent.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "./InstallWindowsAgent.ps1 -JumpCloudConnectKey 'xxx'"

REM Apply Windows Security Baseline
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/SquelchPlop/os-config/master/windows/windows_security_baselines/apply_wsb_win10_nondomain.ps1'))"