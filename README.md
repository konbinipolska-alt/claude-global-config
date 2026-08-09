# claude-global-config

Konbini's personal, cross-project Claude Code configuration: a global
`CLAUDE.md` (communication rules + engineering/design skill index), a
reusable skills library, and output styles, meant to apply in *any* repo,
not just one project.

This repo mirrors `~/.claude/` directly, so syncing it into a project is a
plain copy plus one settings key:

```
CLAUDE.md                     -> ~/.claude/CLAUDE.md
skills/<name>/                -> ~/.claude/skills/<name>/
output-styles/<name>.md       -> ~/.claude/output-styles/<name>.md
"outputStyle": "Clear"        -> merged into ~/.claude/settings.json
```

`install.sh` performs all four steps. It is idempotent, it leaves every
other key in `settings.json` untouched, and it will not override an
`outputStyle` you picked yourself — delete the key (or run
`/output-style Clear`) to go back to the default.

## Installing locally

For the CLI or desktop app, `~/.claude/` persists, so a one-time install is
enough:

```bash
git clone https://github.com/konbinipolska-alt/claude-global-config.git \
  ~/.claude-global-config-sync
bash ~/.claude-global-config-sync/install.sh
```

Re-run those two commands (with `git -C ~/.claude-global-config-sync pull`)
whenever you want the latest config.

## How the sync works

Each consuming project (e.g. `moj-pierwszy-theme`) gets a `SessionStart`
hook that, on every Claude Code on the web session, clones/pulls this repo
and runs its `install.sh`. Because this
repo is public, the hook works with a plain `git clone` — no GitHub App
scope or auth needed in the session that runs it.

The hook only clones and delegates, so changing *what* gets synced is a
change in this repo alone — consuming projects never need updating again.

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

bash "$SYNC_DIR/install.sh"
```

```bash
chmod +x .claude/hooks/session-start.sh
```

Projects still running an older, copy-it-yourself version of this hook keep
working, but they miss whatever that version does not copy — older ones sync
only `CLAUDE.md` and `skills/`, and none of them set the output style.
Replace their `session-start.sh` with the snippet above once, and they stay
current from then on.

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

Edit `CLAUDE.md`, `skills/<name>/SKILL.md`, `output-styles/<name>.md`, or
`install.sh` in this repo, commit, and push.
Consuming projects pick up the change automatically on their next session
(no changes needed in the consuming project itself).
