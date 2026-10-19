#!/usr/bin/env bash
# PreToolUse (Write|Edit|MultiEdit|NotebookEdit): block edits to the read-only
# result directories. Paths are resolved first so ./, ../ and symlinks match.
set -euo pipefail
f="$(jq -r '.tool_input.file_path // .tool_input.notebook_path // empty')"
[ -n "$f" ] || exit 0
root="$(realpath -m -- "${CLAUDE_PROJECT_DIR:-$PWD}")"
abs="$(cd "$root" && realpath -m -- "$f")"
rel="${abs#"$root"/}"
if [[ "$abs" == "$root"/* && "$rel" =~ ^(Data|Outputs)(/|$) ]]; then
  echo "Blocked: $rel is in Data/ or Outputs/. These are fixed research results (read-only). Ask the user before you change them." >&2
  exit 2
fi
