#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

cards=(
  "${repo_root}/docs/top-10-new-user-commands.md"
  "${repo_root}/docs/top-10-power-user-commands.md"
  "${repo_root}/docs/top-10-release-maintainer-commands.md"
)

for card in "${cards[@]}"; do
  if [ ! -f "${card}" ]; then
    echo "Missing top-10 card file: ${card#${repo_root}/}"
    exit 1
  fi

  count="$(grep -E '^[0-9]+\. ' "${card}" | wc -l | tr -d ' ')"
  if [ "${count}" != "10" ]; then
    echo "Top-10 card does not contain exactly 10 numbered items: ${card#${repo_root}/} (found ${count})"
    exit 1
  fi
done

echo "Top-10 card checks passed"
