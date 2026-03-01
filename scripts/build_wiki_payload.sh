#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
out_dir="${1:-${repo_root}/.tmp/wiki-payload}"

rm -rf "${out_dir}"
mkdir -p "${out_dir}"

# Start with curated wiki pages committed in-repo.
cp -R "${repo_root}/wiki/." "${out_dir}/"

to_title() {
	local value="$1"
	value="${value//-/ }"
	value="${value//_/ }"
	printf "%s" "${value}" | awk '{for (i=1;i<=NF;i++) {$i=toupper(substr($i,1,1)) substr($i,2)}; print}'
}

safe_copy_doc() {
	local src="$1"
	local prefix="$2"
	local base name title target
	base="$(basename "${src}")"
	name="${base%.md}"
	title="$(to_title "${name}")"
	target="${out_dir}/${prefix}-${title}.md"

	{
		printf "# %s\n\n" "${prefix}: ${title}"
		printf '_Source: `%s`_\n\n' "${src#${repo_root}/}"
		cat "${src}"
	} >"${target}"
}

# Mirror top-level docs guides.
for src in "${repo_root}"/docs/*.md; do
	[ -f "${src}" ] || continue
	safe_copy_doc "${src}" "Guide"
done

# Mirror cheatsheets as wiki pages.
for src in "${repo_root}"/docs/cheatsheets/*.md; do
	[ -f "${src}" ] || continue
	safe_copy_doc "${src}" "Cheatsheet"
done

index_file="${out_dir}/All-Docs.md"
{
	printf "# All Docs\n\n"
	printf 'Auto-generated index that mirrors `docs/` content for GitHub Wiki readers.\n\n'
	printf "## Guides\n\n"
	for page in "${out_dir}"/Guide-*.md; do
		[ -f "${page}" ] || continue
		base="$(basename "${page}" .md)"
		label="${base#Guide-}"
		printf -- "- [%s](%s)\n" "${label}" "${base}"
	done
	printf "\n## Cheatsheets\n\n"
	for page in "${out_dir}"/Cheatsheet-*.md; do
		[ -f "${page}" ] || continue
		base="$(basename "${page}" .md)"
		label="${base#Cheatsheet-}"
		printf -- "- [%s](%s)\n" "${label}" "${base}"
	done
	printf '\n\n`CONTINUE_TAG: #continue-utils`\n'
} >"${index_file}"

if [ -f "${out_dir}/_Sidebar.md" ]; then
	if ! grep -q "All Docs" "${out_dir}/_Sidebar.md"; then
		printf "\n- [All Docs](All-Docs)\n" >>"${out_dir}/_Sidebar.md"
	fi
fi

echo "Wiki payload ready at: ${out_dir}"
