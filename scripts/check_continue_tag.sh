#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
marker='CONTINUE_TAG: #continue-utils'

required_files=(
	"${repo_root}/README.md"
	"${repo_root}/docs/index.md"
	"${repo_root}/docs/release-flow.md"
	"${repo_root}/docs/workflow-matrix.md"
	"${repo_root}/wiki/Home.md"
	"${repo_root}/wiki/Quick-Command-Cards.md"
)

for file in "${required_files[@]}"; do
	if [ ! -f "${file}" ]; then
		echo "Missing required file: ${file}"
		exit 1
	fi
	if ! grep -Fq "${marker}" "${file}"; then
		echo "Missing continue marker in ${file#${repo_root}/}"
		exit 1
	fi
done

echo "Continue tag checks passed"
