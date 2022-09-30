$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$BIN_DIR = "C:\Windows\System32"
$TMP_DIR = "$($env:USERPROFILE)\AppData\Local\Temp"
$KUBECLT_VERSION = Invoke-WebRequest "https://dl.k8s.io/release/stable.txt" -UseBasicParsing
$KUBECLT_BIN_URL = "https://dl.k8s.io/release/$KUBECLT_VERSION/bin/windows/amd64/kubectl.exe"
$KUBECLT_BIN_SHA256_URL = "https://dl.k8s.io/$KUBECLT_VERSION/bin/windows/amd64/kubectl.exe.sha256"
$KUBELOGIN_VERSION = "v1.25.3"
$KUBELOGIN_BIN_URL = "https://github.com/int128/kubelogin/releases/download/$KUBELOGIN_VERSION/kubelogin_windows_amd64.zip"
$KUBELOGIN_BIN_SHA256_URL = "https://github.com/int128/kubelogin/releases/download/$KUBELOGIN_VERSION/kubelogin_windows_amd64.zip.sha256"

Invoke-WebRequest -Uri $KUBECLT_BIN_URL -OutFile $TMP_DIR\kubectl.exe
Invoke-WebRequest -Uri $KUBECLT_BIN_SHA256_URL -OutFile $TMP_DIR\kubectl.exe.sha256
Invoke-WebRequest -Uri $KUBELOGIN_BIN_URL -OutFile $TMP_DIR\kubelogin_windows_amd64.zip
Invoke-WebRequest -Uri $KUBELOGIN_BIN_SHA256_URL -OutFile $TMP_DIR\kubelogin_windows_amd64.zip.sha256

$($(CertUtil -hashfile $TMP_DIR\kubectl.exe SHA256)[1] -replace " ", "") -eq $(Get-Content $TMP_DIR\kubectl.exe.sha256)
$($(CertUtil -hashfile $TMP_DIR\kubelogin_windows_amd64.zip SHA256)[1] -replace " ", "") -eq $($(Get-Content $TMP_DIR\kubelogin_windows_amd64.zip.sha256) -replace " .*", "")

Expand-Archive $TMP_DIR\kubelogin_windows_amd64.zip -DestinationPath $TMP_DIR\kubelogin
Copy-Item $TMP_DIR\kubectl.exe -Destination $BIN_DIR\kubectl.exe
Copy-Item $TMP_DIR\kubelogin\kubelogin.exe -Destination $BIN_DIR\kubectl-oidc_login.exe

Remove-Item -Path $TMP_DIR\kubectl.*,$TMP_DIR\kubelogin* -Recurse