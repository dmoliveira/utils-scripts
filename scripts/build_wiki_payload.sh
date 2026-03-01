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

to_slug() {
	local value="$1"
	value="${value// /-}"
	printf "%s" "${value}"
}

safe_copy_doc() {
	local src="$1"
	local prefix="$2"
	local base name title slug target
	base="$(basename "${src}")"
	name="${base%.md}"
	title="$(to_title "${name}")"
	slug="$(to_slug "${title}")"
	target="${out_dir}/${prefix}-${slug}.md"

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
		label="${label//-/ }"
		printf -- "- [%s](%s)\n" "${label}" "${base}"
	done
	printf "\n## Cheatsheets\n\n"
	for page in "${out_dir}"/Cheatsheet-*.md; do
		[ -f "${page}" ] || continue
		base="$(basename "${page}" .md)"
		label="${base#Cheatsheet-}"
		label="${label//-/ }"
		printf -- "- [%s](%s)\n" "${label}" "${base}"
	done
	printf '\n\n`CONTINUE_TAG: #continue-utils`\n'
} >"${index_file}"

sidebar_file="${out_dir}/_Sidebar.md"
{
	printf "### utils-scripts\n\n"
	printf -- "- [Home](Home)\n"
	printf -- "- [Getting Started](Getting-Started)\n"
	printf -- "- [Power User Workflows](Power-User-Workflows)\n"
	printf -- "- [Cheatsheets](Cheatsheets)\n"
	printf -- "- [Workflow Matrix](Workflow-Matrix)\n"
	printf -- "- [Troubleshooting](Troubleshooting)\n"
	printf -- "- [Support and Donation](Support-and-Donation)\n"
	printf -- "- [All Docs](All-Docs)\n\n"

	printf "### Guides\n\n"
	for page in "${out_dir}"/Guide-*.md; do
		[ -f "${page}" ] || continue
		base="$(basename "${page}" .md)"
		label="${base#Guide-}"
		label="${label//-/ }"
		printf -- "- [%s](%s)\n" "${label}" "${base}"
	done

	printf "\n### Cheatsheets\n\n"
	for page in "${out_dir}"/Cheatsheet-*.md; do
		[ -f "${page}" ] || continue
		base="$(basename "${page}" .md)"
		label="${base#Cheatsheet-}"
		label="${label//-/ }"
		printf -- "- [%s](%s)\n" "${label}" "${base}"
	done
} >"${sidebar_file}"

echo "Wiki payload ready at: ${out_dir}"
