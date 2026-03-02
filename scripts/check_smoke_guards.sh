#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
workflow="${repo_root}/.github/workflows/smoke-checks.yml"

if [ ! -f "${workflow}" ]; then
  echo "Missing smoke workflow: ${workflow#${repo_root}/}"
  exit 1
fi

required_smoke_checks=(
  "make wiki-build-check"
  "make docs-hub-check"
  "make docs-make-target-check"
  "make ci-quick-guards-check"
  "make quick-commands-sync-check"
  "make golden-path-guards-check"
  "make installer-ci-flags-check"
  "make continue-tag-check"
  "make wiki-source-check"
)

for check_cmd in "${required_smoke_checks[@]}"; do
  if ! grep -Fq "${check_cmd}" "${workflow}"; then
    echo "Smoke workflow missing required guard command: ${check_cmd}"
    exit 1
  fi
done

echo "Smoke guard coverage checks passed"
