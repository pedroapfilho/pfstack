---
name: t3-code-threads
description: >-
  Use when spinning up or messaging a T3 Code coding thread for any coding work
  (features, PR follow-ups, investigations that need a worktree).
---
# T3 Code threads

## When
Use this whenever coding work should run in T3 Code instead of editing a large repo inline: feature work, PR follow-ups, investigations that need a worktree.

## Rules
- Run commands on the machine that has `~/.t3` and T3 Code, never only on a remote sandbox.
- Confirm the T3 Code app/server is up (`pgrep` for T3 Code, or `t3 service status`) before starting a thread.
- Prefer an existing project path under `~/dev/<repo>` that already appears in T3. Add a project with `t3 project add <path>` only when missing.
- Never merge, force-push, release to production, or spend real money without an explicit go from the user in chat.

## Base ref (required, avoids `ref_not_found`)
`t3 thread start --worktree <base>` creates a new branch from `<base>` **locally**. The CLI does **not** fetch remotes for you. If `<base>` is not a local commit-ish, worktree provision fails with `GitVcsDriver.createWorktree.createBranch … ref_not_found`.

Before every start that uses `--worktree`:

1. Pick the base (repo default, `staging`/`production`/`main`/`development`, or a PR head). Per-repo defaults live in your memory repo or `AGENTS.md`, not here.
2. Resolve it on disk:
   ```bash
   git -C ~/dev/<repo> fetch origin <base>
   # Prefer a ref git can resolve right now:
   git -C ~/dev/<repo> rev-parse --verify origin/<base> \
     || git -C ~/dev/<repo> rev-parse --verify <base>
   ```
3. Pass **`--worktree origin/<base>`** when the short name is missing locally. `origin/<base>` works even without T3's `startFromOrigin` flag.
4. If you need a local short name for later CLI calls, create tracking once:
   ```bash
   git -C ~/dev/<repo> branch --track <base> origin/<base>
   ```
5. **Do not** pass `--branch <name>` when that branch already exists (including checked out in another worktree). That fails with `branch_already_exists`. Omit `--branch` and let T3 mint a temp name, or choose a new unique name.

## Start a thread
```bash
# After the base-ref steps above:
t3 thread start --title "<short title>" --worktree origin/<base> --json <project-id-or-path> "<task message>"
```
- `<project-id-or-path>`: project id, project name, or a path inside the project (often `~/dev/<repo>` or `.`).
- Put the full task, acceptance criteria, and relevant `~/agent-memory/<repo>` pointers in the message.
- Omit `--worktree` only when you intentionally want the project root checkout (`type: root`), not a worktree.
- Use `--wait` only when a short reply is enough to continue; otherwise start without waiting and poll later with `t3 thread show`.

## Follow up
```bash
t3 thread send <thread-id> "<message>"
t3 thread show <thread-id> --json
t3 thread list --project <project> --json
```

## Hand back
Report: thread title, link/id, project, what you asked it to do, and any blocker that needs the user.
