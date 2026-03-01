#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

REPO_ROOT="${repo_root}" python3 - <<'PY'
import os
import re
import sys
from pathlib import Path

repo = Path(os.environ["REPO_ROOT"])
makefile = repo / "Makefile"

if not makefile.exists():
    print("Missing Makefile")
    sys.exit(1)

target_pattern = re.compile(r"^([A-Za-z_][A-Za-z0-9_-]*):")
make_targets: set[str] = set()
for line in makefile.read_text(encoding="utf-8").splitlines():
    m = target_pattern.match(line)
    if m:
        make_targets.add(m.group(1))

if not make_targets:
    print("No Make targets found in Makefile")
    sys.exit(1)

doc_files = [repo / "README.md", *sorted((repo / "docs").glob("**/*.md"))]
line_pattern = re.compile(r"(?m)^\s*make\s+([A-Za-z0-9_-]+)\b")
inline_pattern = re.compile(r"`make\s+([A-Za-z0-9_-]+)`")

errors: list[str] = []
for path in doc_files:
    if not path.exists():
        continue
    text = path.read_text(encoding="utf-8")
    matches = list(line_pattern.finditer(text)) + list(inline_pattern.finditer(text))
    for match in matches:
        target = match.group(1)
        if target not in make_targets:
            line_no = text.count("\n", 0, match.start()) + 1
            rel = path.relative_to(repo)
            errors.append(f"{rel}:{line_no} -> make target '{target}' not found")

if errors:
    print("Docs make-target checks failed:")
    for item in errors:
        print(f"- {item}")
    sys.exit(1)

print("Docs make-target checks passed")
PY
