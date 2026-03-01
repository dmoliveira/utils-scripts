#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
payload_dir="${repo_root}/.tmp/wiki-payload"

"${repo_root}/scripts/build_wiki_payload.sh" "${payload_dir}"

required_files=(
  "${payload_dir}/All-Docs.md"
  "${payload_dir}/_Sidebar.md"
  "${payload_dir}/Guide-Workflow-Matrix.md"
  "${payload_dir}/Guide-Top-10-New-User-Commands.md"
)

for file in "${required_files[@]}"; do
  if [ ! -f "${file}" ]; then
    echo "Missing required generated file: ${file}"
    exit 1
  fi
done

if ! grep -q "\[All Docs\](All-Docs)" "${payload_dir}/_Sidebar.md"; then
  echo "Sidebar missing All Docs link"
  exit 1
fi

if ! grep -q "\[Workflow Matrix\](Workflow-Matrix)" "${payload_dir}/_Sidebar.md"; then
  echo "Sidebar missing Workflow Matrix link"
  exit 1
fi

if ! grep -q "\[Quick Command Cards\](Quick-Command-Cards)" "${payload_dir}/_Sidebar.md"; then
  echo "Sidebar missing Quick Command Cards link"
  exit 1
fi

if ! grep -q '`CONTINUE_TAG: #continue-utils`' "${payload_dir}/All-Docs.md"; then
  echo "All-Docs index missing continue marker"
  exit 1
fi

echo "Wiki payload checks passed"
