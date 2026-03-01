#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

required_files=(
  "${repo_root}/README.md"
  "${repo_root}/docs/index.md"
  "${repo_root}/docs/workflow-matrix.md"
  "${repo_root}/docs/top-10-new-user-commands.md"
  "${repo_root}/docs/top-10-power-user-commands.md"
  "${repo_root}/docs/top-10-release-maintainer-commands.md"
  "${repo_root}/wiki/Home.md"
  "${repo_root}/wiki/Quick-Command-Cards.md"
)

for file in "${required_files[@]}"; do
  if [ ! -f "${file}" ]; then
    echo "Missing required docs file: ${file}"
    exit 1
  fi
done

if ! grep -Fq 'CONTINUE_TAG: #continue-utils' "${repo_root}/README.md"; then
  echo "README missing CONTINUE_TAG marker"
  exit 1
fi

if ! grep -Fq '[Top 10 New User Commands](top-10-new-user-commands.md)' "${repo_root}/docs/index.md"; then
  echo "docs/index.md missing new-user quick card link"
  exit 1
fi

if ! grep -Fq '[Top 10 Power User Commands](top-10-power-user-commands.md)' "${repo_root}/docs/index.md"; then
  echo "docs/index.md missing power-user quick card link"
  exit 1
fi

if ! grep -Fq '[Top 10 Release Maintainer Commands](top-10-release-maintainer-commands.md)' "${repo_root}/docs/index.md"; then
  echo "docs/index.md missing release-maintainer quick card link"
  exit 1
fi

if ! grep -Fq '[Quick Command Cards](Quick-Command-Cards)' "${repo_root}/wiki/Home.md"; then
  echo "wiki/Home.md missing Quick Command Cards link"
  exit 1
fi

echo "Docs hub checks passed"
