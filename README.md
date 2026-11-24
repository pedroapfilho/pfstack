# pfstack

My agent setup: the skills, global rules, hooks, and configs I use every day with Claude Code, Codex, Cursor, and T3 Code. Same idea as [pstack](https://github.com/cursor/plugins/tree/main/pstack) and [tstack](https://github.com/t3dotgg/tstack), so fork it and make it yours.

What's in here is what I wrote. Skills other people wrote are listed in [`skills.txt`](skills.txt) and installed from their own repos, so they stay up to date.

## Install

### Everything (skills, deps, rules, hook)
```bash
gh repo clone pedroapfilho/pfstack ~/dev/pfstack
~/dev/pfstack/install.sh
```
Then run `/setup-pfstack` in an agent to merge the settings examples and check the proxy. `install.sh` backs up anything it replaces and never touches your settings files.

### Just the skills
```bash
npx skills add pedroapfilho/pfstack            # pick skills and agents
npx skills add pedroapfilho/pfstack -g --all   # all of them, every agent
```

### Claude Code plugin
```
/plugin marketplace add pedroapfilho/pfstack
/plugin install pfstack@pfstack
```

### Cursor
Add the repo as a plugin. `.cursor-plugin/plugin.json` points at `skills/`.

## Skills

| Skill | Say | What it does |
|---|---|---|
| `t3-code-threads` | "start a T3 thread" | Starts and follows up T3 Code threads in fresh worktrees, resolving the base ref first so `ref_not_found` never happens. |
| `setup-pfstack` | `/setup-pfstack` | Sets up a machine: links skills and rules, installs deps, merges settings, checks the model proxy. |
| `add-to-pfstack` | "add this to pfstack" | Puts a new skill, rule, hook, or config in the right place, scrubs it, and pushes. |

## Global rules

[`AGENTS.md`](AGENTS.md) is linked to `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`, so every agent gets the same rules: no backward-compat layers, grow in layers, no narrative comments, `ponytail` on every coding task, `writing-style` for anything sent as me, actions for me at the top, no AI attribution in commits.

## Layout

```
pfstack/
├── AGENTS.md                  global rules for every agent
├── skills/                    skills I wrote, one folder each
├── skills.txt                 external skills, installed with npx skills
├── hooks/agent-memory.sh      SessionStart hook that loads memory repos
├── config/
│   ├── claude/settings.example.json
│   └── codex/config.example.toml, hooks.json
├── setup/Brewfile, aliases.zsh
├── docs/workflow.md           how it all fits together
├── install.sh
├── .claude-plugin/            Claude Code plugin + marketplace
├── .cursor-plugin/            Cursor plugin
└── plugin.json                agent-plugins manifest
```

## External skills

Installed by `install.sh` from [`skills.txt`](skills.txt):

| Source | Skills |
|---|---|
| [mattpocock/skills](https://github.com/mattpocock/skills) | `grilling`, `grill-me`, `handoff`, `teach`, `wait-what`, `wayfinder`, `codebase-design`, `improve-codebase-architecture` |
| [dietrichgebert/ponytail](https://github.com/dietrichgebert/ponytail) | `ponytail` |
| [t3dotgg/tstack](https://github.com/t3dotgg/tstack) | `council` |
| [cursor/plugins](https://github.com/cursor/plugins) | `thermo-nuclear-code-quality-review` |
| [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | `agent-browser` |
| [vercel-labs/agent-desktop](https://github.com/vercel-labs/agent-desktop) | `agent-desktop` |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | `find-skills` |
| [AgentMemoryRepo/agentmemoryrepo](https://github.com/AgentMemoryRepo/agentmemoryrepo) | `agent-memory-repo` |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | `impeccable` |
| [shadcn/improve](https://github.com/shadcn/improve) | `improve` |
| [caldoai/skills](https://github.com/caldoai/skills) | `untangle-codebase` |
| [humanlayer/skills](https://github.com/humanlayer/skills) | `show-me` |
| [juliusbrussee/caveman](https://github.com/juliusbrussee/caveman) | `caveman` |
| [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop) | `no-ai-slop` |
| [ayghri/i-have-adhd](https://github.com/ayghri/i-have-adhd) | `i-have-adhd` |
| [cloudflare/cloudflare-docs](https://github.com/cloudflare/cloudflare-docs) | `eli5` |

Installed by their own tools, not by pfstack:

- `rex`: `rex skill setup` (rex CLI).
- ui.sh design skills (`design-ui`, `ideas`, `add-dark-mode`, `make-responsive`, `componentize`, `canonicalize-tailwind`, `markup-from-image`, `dark-mode-image`, `brand-kit`) and `before-and-after` (`@vercel/before-and-after`).
- Claude Code plugins from [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official): `figma`, `rust-analyzer-lsp`.
- `writing-style`: my voice guide. It's built from my private messages, so it stays private and isn't part of pfstack.

## Requirements

- `gh` (authenticated), `jq`, `git`, Node (for `npx skills`).
- Claude Code and/or Codex pointed at a model proxy (see [docs/workflow.md](docs/workflow.md)).
- T3 Code for `t3-code-threads`.

## Add your own

See [CONTRIBUTING.md](CONTRIBUTING.md), or tell an agent "add this to pfstack".

## License

MIT
