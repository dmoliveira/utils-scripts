#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
installer="${repo_root}/install_my_programs_unix"
workflow="${repo_root}/.github/workflows/golden-path-bootstrap.yml"

for file in "${installer}" "${workflow}"; do
  if [ ! -f "${file}" ]; then
    echo "Missing required file: ${file#${repo_root}/}"
    exit 1
  fi
done

if ! grep -Fq 'INSTALLER_SKIP_UPGRADE' "${installer}"; then
  echo "Installer missing INSTALLER_SKIP_UPGRADE guard"
  exit 1
fi

if ! grep -Fq 'INSTALLER_SKIP_BR' "${installer}"; then
  echo "Installer missing INSTALLER_SKIP_BR guard"
  exit 1
fi

if ! grep -Fq 'Skipping apt upgrade (INSTALLER_SKIP_UPGRADE=1)' "${installer}"; then
  echo "Installer missing skip-upgrade status message"
  exit 1
fi

if ! grep -Fq 'Skipping br install (INSTALLER_SKIP_BR=1)' "${installer}"; then
  echo "Installer missing skip-br status message"
  exit 1
fi

if ! grep -Fq 'INSTALLER_SKIP_UPGRADE=1 INSTALLER_SKIP_BR=1 timeout 25m ./install_my_programs_unix --skip-ml --skip-fonts' "${workflow}"; then
  echo "Golden path workflow missing installer CI skip flags invocation"
  exit 1
fi

echo "Installer CI flag checks passed"
