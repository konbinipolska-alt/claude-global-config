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

Each consuming project gets a `SessionStart`
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

Run `add-hook.sh` from inside the target repo:

```bash
git clone https://github.com/konbinipolska-alt/claude-global-config.git \
  ~/.claude-global-config-sync   # skip if you already have it
bash ~/.claude-global-config-sync/add-hook.sh
```

It writes `.claude/hooks/session-start.sh`, makes it executable, and
registers it under `hooks.SessionStart` in `.claude/settings.json` — keeping
every other setting and every other hook already in that file. Re-running it
is safe: the hook script gets refreshed, an existing registration is left
alone. Commit `.claude/` and merge it into the project's default branch.

Requires `python3` for the `settings.json` edit; without it the script tells
you what to add by hand.

### Doing it by hand

The generated `.claude/hooks/session-start.sh` is just:

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

Make it executable:

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

Edit `CLAUDE.md`, `skills/<name>/SKILL.md`, `output-styles/<name>.md`, or
`install.sh` in this repo, commit, and push.
(`add-hook.sh` is the exception — it writes a file into the *consuming* repo,
so changing it means re-running it there.)
Consuming projects pick up the change automatically on their next session
(no changes needed in the consuming project itself).
