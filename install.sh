#!/bin/bash
# Install this repo's config into ~/.claude/.
#
# Idempotent: safe to run on every session start. Called by the SessionStart
# hook in consuming projects (see README.md), or by hand for a local install.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
OUTPUT_STYLE="Clear"

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/output-styles"

cp "$SRC_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
cp -r "$SRC_DIR/skills/." "$CLAUDE_DIR/skills/"
cp -r "$SRC_DIR/output-styles/." "$CLAUDE_DIR/output-styles/"

# Set the default output style, without touching any other setting and
# without overriding a style the user picked themselves.
set_output_style() {
  if command -v python3 >/dev/null 2>&1; then
    OUTPUT_STYLE="$OUTPUT_STYLE" SETTINGS_FILE="$SETTINGS_FILE" python3 - <<'PY'
import json, os, pathlib

path = pathlib.Path(os.environ["SETTINGS_FILE"])
style = os.environ["OUTPUT_STYLE"]

settings = {}
if path.exists():
    try:
        loaded = json.loads(path.read_text())
        if isinstance(loaded, dict):
            settings = loaded
        else:
            print(f"warning: {path} is not a JSON object, rewriting it")
    except json.JSONDecodeError:
        print(f"warning: {path} is not valid JSON, rewriting it")

if settings.get("outputStyle") == style:
    raise SystemExit(0)
if "outputStyle" in settings:
    print(f"keeping existing outputStyle {settings['outputStyle']!r}")
    raise SystemExit(0)

settings["outputStyle"] = style
path.write_text(json.dumps(settings, indent=2) + "\n")
PY
  elif command -v jq >/dev/null 2>&1; then
    local current="{}"
    if [ -f "$SETTINGS_FILE" ] && jq -e 'type == "object"' "$SETTINGS_FILE" >/dev/null 2>&1; then
      current="$(cat "$SETTINGS_FILE")"
    elif [ -f "$SETTINGS_FILE" ]; then
      echo "warning: $SETTINGS_FILE is not a JSON object, rewriting it"
    fi
    printf '%s' "$current" \
      | jq --arg style "$OUTPUT_STYLE" 'if has("outputStyle") then . else .outputStyle = $style end' \
      > "$SETTINGS_FILE.tmp"
    mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
  else
    echo "warning: no python3 or jq, skipping outputStyle setup"
  fi
}

set_output_style

echo "claude-global-config installed into $CLAUDE_DIR"
