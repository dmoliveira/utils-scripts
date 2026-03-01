#!/usr/bin/env bash
set -euo pipefail

while IFS= read -r file; do
  [ -f "${file}" ] || continue
  first_line="$(head -n 1 "${file}" 2>/dev/null || true)"
  case "${first_line}" in
    '#!/usr/bin/env bash' | '#!/usr/bin/env sh' | '#!/bin/bash' | '#!/bin/sh')
      printf '%s\n' "${file}"
      ;;
  esac
done < <(git ls-files)
