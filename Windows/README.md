Run:
1. Run powershell as administrator
2. `Set-ExecutionPolicy Bypass -Force`
3. `iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/puzl-cloud/kubectl-oidc/master/Windows/setup.ps1'))`
4. `Set-ExecutionPolicy Restricted -Force`
