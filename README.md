# claude-global-config

Konbini's personal, cross-project Claude Code configuration: a global
`CLAUDE.md` (communication rules + engineering/design skill index) and a
reusable skills library, meant to apply in *any* repo, not just one project.

This repo mirrors `~/.claude/` directly, so syncing it into a project is a
plain copy:

```
CLAUDE.md                     -> ~/.claude/CLAUDE.md
skills/<name>/SKILL.md        -> ~/.claude/skills/<name>/SKILL.md
```

## How the sync works

Each consuming project (e.g. `moj-pierwszy-theme`) gets a `SessionStart`
hook that, on every Claude Code on the web session, clones/pulls this repo
and copies its `CLAUDE.md` and `skills/` into `~/.claude/`. Because this
repo is public, the hook works with a plain `git clone` — no GitHub App
scope or auth needed in the session that runs it.

The hook is synchronous (session start waits for it to finish) so the
config is guaranteed to be in place before Claude starts working, and it's
idempotent (safe to re-run every session).

### Adding the hook to a project

In the target project repo, create `.claude/hooks/session-start.sh`:

```bash
#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

REPO_URL="https://github.com/konbinipolska-alt/claude-global-config.git"
SYNC_DIR="$HOME/.claude-global-config-sync"

if [ -d "$SYNC_DIR/.git" ]; then
  git -C "$SYNC_DIR" pull --ff-only origin main
else
  rm -rf "$SYNC_DIR"
  git clone --depth 1 "$REPO_URL" "$SYNC_DIR"
fi

mkdir -p "$HOME/.claude/skills"
cp "$SYNC_DIR/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
cp -r "$SYNC_DIR/skills/." "$HOME/.claude/skills/"
```

```bash
chmod +x .claude/hooks/session-start.sh
```

Then register it in the project's `.claude/settings.json` (merge if the
file already has other hooks):

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/session-start.sh"
          }
        ]
      }
    ]
  }
}
```

Commit and push to the project's default branch — once merged, every future
Claude Code on the web session for that project will start with this
config already in place.

## Updating the config

Edit `CLAUDE.md` or `skills/<name>/SKILL.md` in this repo, commit, and push.
Consuming projects pick up the change automatically on their next session
(no changes needed in the consuming project itself).
