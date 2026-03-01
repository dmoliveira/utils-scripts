#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
makefile="${repo_root}/Makefile"

if [ ! -f "${makefile}" ]; then
  echo "Missing Makefile"
  exit 1
fi

if ! grep -Fq 'ci-quick:' "${makefile}"; then
  echo "Makefile missing ci-quick target"
  exit 1
fi

required_ci_quick_steps=(
  'pre-commit run --all-files'
  'make docs-hub-check'
  'make docs-make-target-check'
  'make continue-tag-check'
  'make wiki-source-check'
  'make wiki-sidebar-check'
  'make wiki-build-check'
  'make release-template-check'
  'make release-docs-check'
  'make workflow-inventory-check'
  'make core-commands-check'
  'make docs-assets-check'
  'make cheatsheet-index-check'
  'make quick-cards-check'
  'make top10-cards-check'
  'make golden-path-guards-check'
)

for step in "${required_ci_quick_steps[@]}"; do
  if ! grep -Fq "${step}" "${makefile}"; then
    echo "ci-quick missing required step: ${step}"
    exit 1
  fi
done

echo "ci-quick guard coverage checks passed"
