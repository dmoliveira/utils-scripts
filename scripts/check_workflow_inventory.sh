#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
workflows_dir="${repo_root}/.github/workflows"

required_workflows=(
	"smoke-checks.yml"
	"link-check.yml"
	"docs-pages.yml"
	"wiki-sync.yml"
	"release-on-tag.yml"
	"release-e2e-check.yml"
)

for workflow in "${required_workflows[@]}"; do
	path="${workflows_dir}/${workflow}"
	if [ ! -f "${path}" ]; then
		echo "Missing required workflow: ${path#${repo_root}/}"
		exit 1
	fi
done

readme="${repo_root}/README.md"
if [ ! -f "${readme}" ]; then
	echo "Missing README.md"
	exit 1
fi

for workflow in "${required_workflows[@]}"; do
	if ! grep -Fq "${workflow}" "${readme}"; then
		echo "README missing workflow reference: ${workflow}"
		exit 1
	fi
done

echo "Workflow inventory checks passed"
