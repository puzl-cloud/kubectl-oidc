Run:
1. Run powershell as administrator
2. `Set-ExecutionPolicy Bypass`
3. `iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/puzl-cloud/kubectl-oidc/blob/master/Windows/setup.ps1'))`
4. `Set-ExecutionPolicy Restricted`