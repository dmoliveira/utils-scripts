#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
template="${repo_root}/.github/RELEASE_NOTES_TEMPLATE.md"

if [ ! -f "${template}" ]; then
	echo "Missing release template: ${template}"
	exit 1
fi

required_headings=(
	"## 📣 Executive Summary"
	"## ✨ Adds"
	"## 🔄 Changes"
	"## 🛠 Fixes"
	"## 🧹 Removals"
	"## ⬆️ Upgrade Notes"
	"## ❤️ Supporters Changelog"
)

for heading in "${required_headings[@]}"; do
	if ! grep -Fq "${heading}" "${template}"; then
		echo "Missing heading in release template: ${heading}"
		exit 1
	fi
done

required_placeholders=("{{VERSION}}" "{{DATE}}")
for marker in "${required_placeholders[@]}"; do
	if ! grep -Fq "${marker}" "${template}"; then
		echo "Missing placeholder in release template: ${marker}"
		exit 1
	fi
done

echo "Release template checks passed"
