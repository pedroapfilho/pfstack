---
name: setup-pfstack
description: >-
  Set up pfstack on this machine: link its skills and AGENTS.md into Claude Code
  and Codex, install the external skills it depends on, add the agent memory
  hook, and point Claude Code and Codex at the local model proxy. Use when the
  user says "setup pfstack", "install pfstack", or sets up a new machine.
disable-model-invocation: true
---
# Setup pfstack

`<pfstack>` is the folder holding this repo (usually `~/dev/pfstack`). Clone it there first if it is missing: `gh repo clone pedroapfilho/pfstack ~/dev/pfstack`.

1. Run `<pfstack>/install.sh`. It links `skills/*` into `~/.agents/skills` and `~/.claude/skills`, installs everything in `skills.txt` with `npx skills add -g`, and links `AGENTS.md` to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`. It backs up anything it replaces as `<file>.bak-<timestamp>`.
2. Settings are merged by hand, never overwritten. Back up `~/.claude/settings.json`, then merge in the keys from `config/claude/settings.example.json` that are missing. Do the same for `~/.codex/config.toml` with `config/codex/config.example.toml`, and copy `config/codex/hooks.json` to `~/.codex/hooks.json` if none exists.
3. Model proxy. Claude Code and Codex talk to a local CLIProxyAPI. Read the port and an api-key from the proxy's `config.yaml` and put them in `ANTHROPIC_BASE_URL` / `ANTHROPIC_AUTH_TOKEN` (Claude) and the `vibeproxy` provider (Codex). Never print the key back to the user. Make sure `CLAUDE_CODE_OAUTH_TOKEN` is not exported in the shell, since it wins over the proxy.
4. Memory. Make sure `~/agent-memory/` holds the memory repos and an `orgs` file (see `hooks/orgs.example`). Do not create or clone private repos without asking.
5. Shell. Offer to add `source <pfstack>/setup/aliases.zsh` to `~/.zshrc` and `brew bundle --file <pfstack>/setup/Brewfile`.
6. Verify: `claude -p 'say ok'` answers, `ls -la ~/.claude/skills` shows the links, and a new session prints the memory block.

Report what changed, every backup path, and anything left for the user.
