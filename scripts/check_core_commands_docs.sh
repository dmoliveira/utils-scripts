#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

readme="${repo_root}/README.md"
docs_index="${repo_root}/docs/index.md"

for file in "${readme}" "${docs_index}"; do
  if [ ! -f "${file}" ]; then
    echo "Missing required file: ${file}"
    exit 1
  fi
done

required_commands=(
  "make verify"
  "make ci-quick"
  "make release-precheck"
  "make release-docs-check"
  "make workflow-inventory-check"
)

for cmd in "${required_commands[@]}"; do
  if ! grep -Fq "${cmd}" "${readme}"; then
    echo "README missing core command: ${cmd}"
    exit 1
  fi
  if ! grep -Fq "${cmd}" "${docs_index}"; then
    echo "docs/index.md missing quick command: ${cmd}"
    exit 1
  fi
done

echo "Core commands docs checks passed"
