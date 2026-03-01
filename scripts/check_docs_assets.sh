#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

hero_svg="${repo_root}/docs/assets/hero-gpt-image-1.svg"
readme="${repo_root}/README.md"
docs_index="${repo_root}/docs/index.md"

for file in "${hero_svg}" "${readme}" "${docs_index}"; do
	if [ ! -f "${file}" ]; then
		echo "Missing required docs asset/input: ${file#${repo_root}/}"
		exit 1
	fi
done

if ! grep -Fq 'docs/assets/hero-gpt-image-1.svg' "${readme}"; then
	echo "README missing hero image reference"
	exit 1
fi

if ! grep -Fq 'assets/hero-gpt-image-1.svg' "${docs_index}"; then
	echo "docs/index.md missing hero image reference"
	exit 1
fi

if ! grep -Fq 'Prompt origin: GPT-Image-1 concept' "${hero_svg}"; then
	echo "Hero SVG missing GPT-Image-1 provenance marker"
	exit 1
fi

echo "Docs assets checks passed"
