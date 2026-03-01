#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
workflow="${repo_root}/.github/workflows/golden-path-bootstrap.yml"

if [ ! -f "${workflow}" ]; then
  echo "Missing workflow file: ${workflow#${repo_root}/}"
  exit 1
fi

required_snippets=(
  "timeout-minutes: 60"
  'group: golden-path-bootstrap-${{ github.repository }}'
  "cancel-in-progress: true"
  "set -eu"
  "timeout 45m ./install_my_programs_unix --skip-ml --skip-fonts"
)

for snippet in "${required_snippets[@]}"; do
  if ! grep -Fq "${snippet}" "${workflow}"; then
    echo "Golden path workflow missing required guard snippet: ${snippet}"
    exit 1
  fi
done

if grep -Fq 'pipefail' "${workflow}"; then
  echo "Golden path workflow should avoid pipefail under /bin/sh runner"
  exit 1
fi

echo "Golden path guard checks passed"
