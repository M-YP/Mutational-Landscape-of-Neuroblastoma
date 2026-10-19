#!/usr/bin/env bash
# PostToolUse (Write|Edit): syntax-check edited JSON and shell files.
set -uo pipefail
f="$(jq -r '.tool_response.filePath // .tool_input.file_path // empty')"
[ -n "$f" ] && [ -f "$f" ] || exit 0
if [[ "$f" == *.json ]]; then
  out="$(jq empty "$f" 2>&1)" || { echo "Invalid JSON in $f: $out" >&2; exit 2; }
elif [[ "$f" == *.sh ]] || head -n1 "$f" | grep -qE '^#!.*\b(ba)?sh\b'; then
  out="$(bash -n "$f" 2>&1)" || { echo "Shell syntax error in $f: $out" >&2; exit 2; }
fi
exit 0
