---
name: add-to-pfstack
description: >-
  Add a skill, rule, hook, or config to pfstack, the user's public setup repo.
  Use when the user says "add this to pfstack", "save this skill to pfstack",
  or wants a new skill or workflow kept in their stack.
---
# Add to pfstack

`<pfstack>` is the local clone (usually `~/dev/pfstack`). It is a public repo, so nothing private goes in.

## Pick the right place

| Thing | Where |
|---|---|
| A skill the user wrote | `skills/<name>/SKILL.md` (+ `references/`, `scripts/`) |
| A skill someone else wrote | one line in `skills.txt`: `<owner/repo> <skill> ...`. Never vendor it. |
| A global rule for every agent | `AGENTS.md` |
| A hook script | `hooks/`, wired up in `config/*` examples |
| Harness settings | `config/<harness>/`, as a sanitized example |
| Shell or machine setup | `setup/` |

## Write a skill

1. Folder name is kebab-case and matches `name:` in the frontmatter.
2. `description` says what it does and when to trigger it, in one or two sentences. Add `disable-model-invocation: true` when it should only run on request.
3. Keep `SKILL.md` short. Move long material to `references/` and link it.
4. Write for any machine: `~` instead of `/Users/<name>`, no org, project, repo, or person names. Per-repo defaults belong in the memory repos.

## Before committing

1. Scrub: `rg -n -i 'sk-|ghp_|gho_|github_pat_|bearer |api[_-]?key|token|password|secret|/Users/' <pfstack>` and fix every real hit.
2. Add the skill to the table in `README.md`.
3. Run `./install.sh --skills` so the new skill is linked locally.
4. Commit with a short conventional message (`feat: add <name> skill`), no AI attribution, and push to `main`.
