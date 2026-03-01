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

required_shared_commands=(
	"make verify"
	"make ci-quick"
	"make release-precheck"
	"make release-docs-check"
	"make workflow-inventory-check"
	"make core-commands-check"
	"make docs-assets-check"
	"make cheatsheet-index-check"
	"make quick-cards-check"
	"make top10-cards-check"
	"make golden-path-guards-check"
	"make ci-quick-guards-check"
	"make wiki-sidebar-check"
	"make docs-hub-check"
)

for cmd in "${required_shared_commands[@]}"; do
	if ! grep -Fq "${cmd}" "${readme}"; then
		echo "README missing shared quick command: ${cmd}"
		exit 1
	fi
	if ! grep -Fq "${cmd}" "${docs_index}"; then
		echo "docs/index.md missing shared quick command: ${cmd}"
		exit 1
	fi
done

echo "Quick commands sync checks passed"
