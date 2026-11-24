# Workflow

How the pieces fit together day to day.

## Harnesses
- **T3 Code** is the main place coding threads run. Each task gets its own thread and git worktree (`t3-code-threads` skill). Threads run Claude Code or Codex underneath.
- **Claude Code** and **Codex** both read the same global rules: `AGENTS.md` is linked to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`.
- **Cursor** reads the same skills through the plugin manifest in `.cursor-plugin/`.

## Models through one local proxy
Claude Code and Codex don't log in on their own. Both talk to a local [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) (VibeProxy on macOS), which holds the subscription logins:
- Claude Code: `ANTHROPIC_BASE_URL` + `ANTHROPIC_AUTH_TOKEN` in `~/.claude/settings.json`.
- Codex: the `vibeproxy` model provider in `~/.codex/config.toml`.

If Claude Code says its login "reached its time limit", it is ignoring the proxy: check that `ANTHROPIC_AUTH_TOKEN` is set in settings and that `CLAUDE_CODE_OAUTH_TOKEN` is not exported.

## Memory
`hooks/agent-memory.sh` runs at session start in both Claude Code and Codex. It picks the memory repo from the repo's GitHub org (`~/agent-memory/orgs`) and prints that workspace's `MEMORY.md` plus `personal/MEMORY.md`. Agents write back with the `agent-memory-repo` skill and push. One private repo per workspace keeps memories apart.

## Defaults every agent follows
- `ponytail` on every coding task: smallest change that fully solves it.
- `writing-style` for anything sent as me.
- Actions I need to take go at the top of the reply.
- No AI attribution in commits or PRs. Signed commits only.

## Terminal
- rex sessions and tabs (`rex` skill, SessionStart hook).
- Aliases in `setup/aliases.zsh`: `up` updates everything including skills, `lfg` and `peek` are quick Claude reviews of the current branch.
