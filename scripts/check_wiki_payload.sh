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

PAYLOAD_DIR="${payload_dir}" python3 - <<'PY'
import os
import re
import sys
from pathlib import Path

payload = Path(os.environ["PAYLOAD_DIR"])
pattern = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
errors = []

for md_file in payload.glob("*.md"):
    if md_file.name.startswith(("Guide-", "Cheatsheet-")):
        continue
    content = md_file.read_text(encoding="utf-8")
    for target in pattern.findall(content):
        target = target.strip()
        if not target:
            continue
        if target.startswith(("http://", "https://", "mailto:", "#")):
            continue
        target = target.split("#", 1)[0].split("?", 1)[0].strip()
        if not target:
            continue

        candidates = []
        if target.endswith(".md"):
            candidates.append(payload / target)
        else:
            candidates.append(payload / target)
            candidates.append(payload / f"{target}.md")

        if not any(candidate.exists() for candidate in candidates):
            errors.append(f"{md_file.name}: broken link target '{target}'")

if errors:
    print("Wiki payload link checks failed:")
    for item in errors:
        print(f"- {item}")
    sys.exit(1)

print("Wiki payload internal link checks passed")
PY

echo "Wiki payload checks passed"
