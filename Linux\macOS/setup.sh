#!/usr/bin/env bash

set -euo pipefail

BIN_DIR="/usr/local/bin"
OS="$(uname -s | awk '{print tolower($0)}')"
ARCHITECTURE="$(uname -m)"
KUBELOGIN_VERSION="v1.25.3"
TMP_DIR="/tmp"

case $ARCHITECTURE in
  x86_64)
    ARCHITECTURE="amd64"
    ;;
esac

KUBECTL_BIN_URL="https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/${OS}/${ARCHITECTURE}/kubectl"
KUBECTL_BIN_SHA256_URL="https://dl.k8s.io/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/${OS}/${ARCHITECTURE}/kubectl.sha256"
KUBELOGIN_BIN_URL="https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin_${OS}_${ARCHITECTURE}.zip"
KUBELOGIN_BIN_SHA256_URL="https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin_${OS}_${ARCHITECTURE}.zip.sha256"

curl -L "${KUBECTL_BIN_URL}" -o ${TMP_DIR}/kubectl
curl -L "${KUBELOGIN_BIN_URL}" -o ${TMP_DIR}/kubelogin_${OS}_${ARCHITECTURE}.zip

cd ${TMP_DIR}
if [[ "${OS}" == "linux" ]]; then
  echo "$(curl -sL ${KUBECTL_BIN_SHA256_URL})  kubectl" | sha256sum --check
  echo "$(curl -sL ${KUBELOGIN_BIN_SHA256_URL})" | sha256sum --check
elif [[ "${OS}" == "darwin" ]]; then
  echo "$(curl -sL ${KUBECTL_BIN_SHA256_URL})  kubectl" | shasum -a 256 --check
  echo "$(curl -sL ${KUBELOGIN_BIN_SHA256_URL})" | shasum -a 256 --check
fi
unzip -qu kubelogin_${OS}_${ARCHITECTURE}.zip -d kubelogin
chmod +x kubectl kubelogin/kubelogin
cd ${OLDPWD}

mv ${TMP_DIR}/{kubectl,kubelogin/kubelogin} ${BIN_DIR}/
rm -rf ${TMP_DIR}/kubelogin_${OS}_${ARCHITECTURE}.zip ${TMP_DIR}/kubelogin
