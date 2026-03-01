#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
sidebar="${repo_root}/wiki/_Sidebar.md"
home="${repo_root}/wiki/Home.md"

for file in "${sidebar}" "${home}"; do
  if [ ! -f "${file}" ]; then
    echo "Missing required wiki file: ${file#${repo_root}/}"
    exit 1
  fi
done

required_sidebar_links=(
  "[Home](Home)"
  "[Getting Started](Getting-Started)"
  "[Power User Workflows](Power-User-Workflows)"
  "[Cheatsheets](Cheatsheets)"
  "[Workflow Matrix](Workflow-Matrix)"
  "[Quick Command Cards](Quick-Command-Cards)"
  "[Troubleshooting](Troubleshooting)"
  "[Support and Donation](Support-and-Donation)"
)

for link in "${required_sidebar_links[@]}"; do
  if ! grep -Fq "${link}" "${sidebar}"; then
    echo "wiki/_Sidebar.md missing required link: ${link}"
    exit 1
  fi
done

if ! grep -Fq '[Quick Command Cards](Quick-Command-Cards)' "${home}"; then
  echo "wiki/Home.md missing Quick Command Cards link"
  exit 1
fi

echo "Wiki sidebar source checks passed"
