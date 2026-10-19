#!/usr/bin/env bash
# PreToolUse (Write|Edit): block edits to the read-only result directories.
set -euo pipefail
f="$(jq -r '.tool_input.file_path // empty')"
[ -n "$f" ] || exit 0
rel="${f#"${CLAUDE_PROJECT_DIR:-$PWD}"/}"
if [[ "$rel" =~ ^(Data|Outputs)/ ]]; then
  echo "Blocked: $rel is in Data/ or Outputs/. These are fixed research results (read-only). Ask the user before you change them." >&2
  exit 2
fi
