#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

docs_index="${repo_root}/docs/index.md"
wiki_quick="${repo_root}/wiki/Quick-Command-Cards.md"

required_files=(
	"${repo_root}/docs/top-10-new-user-commands.md"
	"${repo_root}/docs/top-10-power-user-commands.md"
	"${repo_root}/docs/top-10-release-maintainer-commands.md"
	"${docs_index}"
	"${wiki_quick}"
)

for file in "${required_files[@]}"; do
	if [ ! -f "${file}" ]; then
		echo "Missing required quick-card file: ${file#${repo_root}/}"
		exit 1
	fi
done

for link in \
	"Top 10 New User Commands" \
	"Top 10 Power User Commands" \
	"Top 10 Release Maintainer Commands"; do
	if ! grep -Fq "${link}" "${docs_index}"; then
		echo "docs/index.md missing quick-card link label: ${link}"
		exit 1
	fi
done

for wiki_target in \
	"Guide-Top-10-New-User-Commands" \
	"Guide-Top-10-Power-User-Commands" \
	"Guide-Top-10-Release-Maintainer-Commands"; do
	if ! grep -Fq "${wiki_target}" "${wiki_quick}"; then
		echo "wiki/Quick-Command-Cards.md missing mirror target: ${wiki_target}"
		exit 1
	fi
done

echo "Quick cards checks passed"
