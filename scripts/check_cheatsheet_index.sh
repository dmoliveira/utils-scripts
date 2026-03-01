#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
index_file="${repo_root}/docs/cheatsheets/index.md"
cheatsheets_dir="${repo_root}/docs/cheatsheets"

if [ ! -f "${index_file}" ]; then
	echo "Missing cheatsheet index: ${index_file#${repo_root}/}"
	exit 1
fi

if [ ! -d "${cheatsheets_dir}" ]; then
	echo "Missing cheatsheets directory: ${cheatsheets_dir#${repo_root}/}"
	exit 1
fi

missing=0
for file in "${cheatsheets_dir}"/*.md; do
	[ -f "${file}" ] || continue
	base="$(basename "${file}")"
	if [ "${base}" = "index.md" ]; then
		continue
	fi
	if ! grep -Fq "(${base})" "${index_file}"; then
		echo "Cheatsheet missing from index: ${base}"
		missing=1
	fi
done

if [ "${missing}" -ne 0 ]; then
	exit 1
fi

echo "Cheatsheet index checks passed"
