#!/bin/bash
# Cloud environment setup script.
#
# Paste this into the Setup script field of your cloud environment at
# claude.ai/code. It then applies to every cloud session in that
# environment, in every repository, with nothing to add to the repos
# themselves.
#
# See README.md ("Covering every repo at once") for the tradeoff against
# the per-repo SessionStart hook.

# No `set -e`: a setup script that exits non-zero stops the session from
# starting, and missing config is not worth a dead session.
set -uo pipefail

REPO_URL="https://github.com/konbinipolska-alt/claude-global-config.git"
SYNC_DIR="$HOME/.claude-global-config-sync"

rm -rf "$SYNC_DIR"
if git clone --depth 1 "$REPO_URL" "$SYNC_DIR"; then
  bash "$SYNC_DIR/install.sh" || echo "warning: install.sh failed"
else
  echo "warning: could not clone $REPO_URL"
fi

exit 0
