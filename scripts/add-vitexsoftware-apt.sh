#!/usr/bin/env bash
set -euo pipefail

# Configure VitexSoftware APT repository inside a Debian/Ubuntu container.
# Usage:
#   add-vitexsoftware-apt.sh <distro_codename> <repo_url> [key_url]
# Example:
#   add-vitexsoftware-apt.sh bookworm https://repo.vitexsoftware.eu https://repo.vitexsoftware.eu/KEY.gpg
# Notes:
# - If key_url is omitted, the repo list will be written but left commented to avoid insecure configuration.
# - This script is intended for use during image build (RUN stage).

CODENAME="${1:-}"
REPO_URL="${2:-}"
KEY_URL="${3:-}"

if [[ -z "${CODENAME}" || -z "${REPO_URL}" ]]; then
  echo "Usage: $0 <distro_codename> <repo_url> [key_url]" >&2
  exit 2
fi

mkdir -p /etc/apt/keyrings /etc/apt/sources.list.d
LIST_FILE="/etc/apt/sources.list.d/vitexsoftware.list"
KEYRING="/etc/apt/keyrings/vitexsoftware.gpg"

if [[ -n "${KEY_URL}" ]]; then
  echo "Fetching APT key from ${KEY_URL} ..."
  if curl -fsSL "${KEY_URL}" | gpg --dearmor > "${KEYRING}"; then
    chmod 0644 "${KEYRING}"
    echo "deb [signed-by=${KEYRING}] ${REPO_URL} ${CODENAME} main backports" > "${LIST_FILE}"
  else
    echo "WARNING: Failed to fetch key from ${KEY_URL}. Writing commented repo entry instead." 1>&2
    echo "# Failed to fetch key from: ${KEY_URL}" > "${LIST_FILE}"
    echo "# deb [signed-by=/etc/apt/keyrings/vitexsoftware.gpg] ${REPO_URL} ${CODENAME} main" >> "${LIST_FILE}"
  fi
else
  echo "WARNING: No key URL provided. Writing a commented repo entry to ${LIST_FILE}." 1>&2
  echo "# Provide a key at build time to enable this repo:" > "${LIST_FILE}"
  echo "# deb [signed-by=/etc/apt/keyrings/vitexsoftware.gpg] ${REPO_URL} ${CODENAME} main" >> "${LIST_FILE}"
fi

# Do not run apt-get update here automatically; leave it to the Dockerfile.
echo "VitexSoftware APT configuration written to ${LIST_FILE}."

