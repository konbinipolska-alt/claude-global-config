#!/bin/bash
# Install this repo's config into ~/.claude/.
#
# Idempotent: safe to run on every session start. Called by bootstrap.sh, by
# the user-level SessionStart hook it registers, by the cloud setup script, or
# by hand.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
OUTPUT_STYLE="Clear"
SYNC_COMMAND="\$HOME/.claude-global-config-sync/sync.sh"
CONFLICT_DIR="$CLAUDE_DIR/skills-conflicts"

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/output-styles"

cp "$SRC_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Copy the skills one directory at a time. A skill name that already exists
# in ~/.claude/skills as a plain file makes `cp -r` fail, and under `set -e`
# that aborted the whole install before it reached settings.json — leaving no
# output style and no sync hook. Move the offender aside and carry on.
install_skill() {
  local src="${1%/}"
  local name dest
  name="$(basename "$src")"
  dest="$CLAUDE_DIR/skills/$name"

  if [ -e "$dest" ] && [ ! -d "$dest" ]; then
    mkdir -p "$CONFLICT_DIR"
    mv "$dest" "$CONFLICT_DIR/$name"
    echo "moved $dest to $CONFLICT_DIR: it was a file, not a skill directory"
  fi

  cp -r "$src" "$CLAUDE_DIR/skills/"
}

for skill in "$SRC_DIR"/skills/*/; do
  install_skill "$skill"
done

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

# Register a user-level SessionStart hook, so every later session re-syncs on
# its own — locally and in the cloud, in every project, with nothing to
# remember and nothing committed to the project repos.
register_session_hook() {
  if ! command -v python3 >/dev/null 2>&1; then
    echo "warning: no python3, skipping SessionStart hook setup"
    return 0
  fi

  SETTINGS_FILE="$SETTINGS_FILE" SYNC_COMMAND="$SYNC_COMMAND" python3 - <<'PY'
import json, os, pathlib

path = pathlib.Path(os.environ["SETTINGS_FILE"])
command = os.environ["SYNC_COMMAND"]

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

hooks = settings.setdefault("hooks", {})
if not isinstance(hooks, dict):
    hooks = settings["hooks"] = {}
matchers = hooks.setdefault("SessionStart", [])
if not isinstance(matchers, list):
    matchers = hooks["SessionStart"] = []

for matcher in matchers:
    if not isinstance(matcher, dict):
        continue
    for hook in matcher.get("hooks", []):
        if isinstance(hook, dict) and "claude-global-config-sync" in str(hook.get("command", "")):
            raise SystemExit(0)

matchers.append({"hooks": [{"type": "command", "command": command}]})
path.write_text(json.dumps(settings, indent=2) + "\n")
print("registered the SessionStart sync hook in settings.json")
PY
}

register_session_hook

chmod +x "$SRC_DIR/sync.sh" "$SRC_DIR/bootstrap.sh" 2>/dev/null || true

echo "claude-global-config installed into $CLAUDE_DIR"
