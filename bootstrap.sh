#!/bin/bash
# One-time setup for a machine.
#
# Clones this repo, installs it into ~/.claude/, and registers the user-level
# SessionStart hook that keeps it up to date from then on. Run it once per
# machine — after that every session re-syncs on its own:
#
#   curl -fsSL https://raw.githubusercontent.com/konbinipolska-alt/claude-global-config/main/bootstrap.sh | bash
#
# Re-running it is safe.
set -uo pipefail

REPO_URL="https://github.com/konbinipolska-alt/claude-global-config.git"
SYNC_DIR="$HOME/.claude-global-config-sync"

if [ -d "$SYNC_DIR/.git" ]; then
  git -C "$SYNC_DIR" pull --ff-only origin main || \
    echo "warning: could not pull, using the copy on disk"
else
  rm -rf "$SYNC_DIR"
  if ! git clone --depth 1 "$REPO_URL" "$SYNC_DIR"; then
    echo "error: could not clone $REPO_URL" >&2
    exit 1
  fi
fi

bash "$SYNC_DIR/install.sh"
