#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

release_flow="${repo_root}/docs/release-flow.md"
top10_release="${repo_root}/docs/top-10-release-maintainer-commands.md"
readme="${repo_root}/README.md"

for file in "${release_flow}" "${top10_release}" "${readme}"; do
	if [ ! -f "${file}" ]; then
		echo "Missing required file: ${file}"
		exit 1
	fi
done

if ! grep -Fq 'make release-precheck' "${release_flow}"; then
	echo "release-flow.md missing make release-precheck"
	exit 1
fi

if ! grep -Fq 'git tag "${VERSION}"' "${release_flow}"; then
	echo "release-flow.md missing git tag command"
	exit 1
fi

if ! grep -Fq 'git push origin "${VERSION}"' "${release_flow}"; then
	echo "release-flow.md missing git push tag command"
	exit 1
fi

if ! grep -Fq 'git tag vX.Y.Z && git push origin vX.Y.Z' "${top10_release}"; then
	echo "top-10 release commands missing combined tag+push command"
	exit 1
fi

if ! grep -Fq 'make release-precheck' "${readme}"; then
	echo "README missing make release-precheck in core commands"
	exit 1
fi

if ! grep -Fq 'make ci-quick' "${readme}"; then
	echo "README missing make ci-quick in core commands"
	exit 1
fi

echo "Release docs consistency checks passed"
