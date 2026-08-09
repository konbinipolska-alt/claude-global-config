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

## Installing on a machine

One command, once per machine — laptop, desktop app, CLI:

```bash
curl -fsSL https://raw.githubusercontent.com/konbinipolska-alt/claude-global-config/main/bootstrap.sh | bash
```

`bootstrap.sh` clones this repo to `~/.claude-global-config-sync`, runs
`install.sh`, and — this is the part that makes it stick — registers a
**user-level `SessionStart` hook** in `~/.claude/settings.json` pointing at
`sync.sh`. From then on every session in every project pulls `main` and
re-installs before Claude starts. Nothing to remember, nothing to re-run.

`sync.sh` never fails a session: if the pull fails (offline, GitHub down) it
warns and keeps the copy already on disk.

To stop the auto-sync, delete that hook from `~/.claude/settings.json`.

## Covering the cloud

Cloud containers are ephemeral, so `~/.claude/` does not persist between
sessions and the bootstrap has to be part of the image.

**The environment setup script** (`setup-script.sh`) is configured once, in
the environment dialog at [claude.ai/code](https://claude.ai/code), and then
applies to every cloud session in that environment — every repository,
including ones that do not exist yet, with nothing committed to them. Paste
the file's contents into the **Setup script** field.

Its limit used to be caching: Anthropic runs the setup script once, snapshots
the filesystem, and reuses that snapshot for later sessions, so a session
picked up whatever config existed when the snapshot was built. The user-level
hook fixes that — the snapshot now carries the hook, and the hook pulls fresh
`main` on every session, however old the snapshot is.

**The per-repo SessionStart hook** (`add-hook.sh`, below) does the same job
for a single repo, at the cost of a `.claude/` directory committed to it. It
is a fallback for repos in environments you do not control; with the
user-level hook in place you rarely need it. When both are present the second
one re-syncs over the first, which is harmless.

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
