#!/bin/bash
# Pull the latest config and install it.
#
# This is what the user-level SessionStart hook runs, so it must never stop a
# session from starting: no `set -e`, and every failure is a warning that
# falls back to the copy already on disk.
set -uo pipefail

SYNC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! git -C "$SYNC_DIR" pull --ff-only origin main >/dev/null 2>&1; then
  echo "claude-global-config: could not pull, using the copy on disk"
fi

bash "$SYNC_DIR/install.sh" || echo "claude-global-config: install.sh failed"

exit 0
