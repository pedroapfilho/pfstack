# Adding to pfstack

pfstack is public. Nothing private goes in: no keys, tokens, emails, phone numbers, absolute home paths, or names of orgs, projects, or people.

## Add a skill you wrote
1. `mkdir skills/<name>` and write `skills/<name>/SKILL.md`:
   ```markdown
   ---
   name: <name>
   description: What it does and when to use it, in one or two sentences.
   ---
   # <Title>
   ...
   ```
   Folder name and `name:` match, kebab-case. Long material goes in `references/`, scripts in `scripts/`.
2. Add a row to the skills table in `README.md`.
3. `./install.sh --skills` to link it locally.

Or ask an agent: "add this to pfstack". The `add-to-pfstack` skill does the steps above.

## Add someone else's skill
Don't copy it in. Add a line to `skills.txt` (`<owner/repo> <skill> ...`) and `./install.sh --deps`.

## Change rules, hooks, or configs
- Global rules: `AGENTS.md`.
- Hooks: `hooks/`, then reference them in `config/claude/settings.example.json` and `config/codex/hooks.json`.
- Settings: edit the `*.example*` files. Real settings stay on your machine.

## Before pushing
```bash
rg -n -i 'sk-|ghp_|gho_|github_pat_|bearer |api[_-]?key|token|password|secret|/Users/' .
```
Fix any real hit. Bump `version` in `plugin.json`, `.claude-plugin/plugin.json`, and `.cursor-plugin/plugin.json` when skills change.
