## How to use

1. Run powershell as Administrator.
1. Execute `Set-ExecutionPolicy Bypass -Force`. Press `y`, if it asks you to confirm your action.
1. Execute `iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/puzl-cloud/kubectl-oidc/master/Windows/setup.ps1'))`.
1. Execute `Set-ExecutionPolicy Restricted -Force`.
