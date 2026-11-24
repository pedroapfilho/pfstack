# AGENTS.md

- Do not preserve backward compatibility. Remove obsolete paths instead of adding compatibility layers, fallbacks, or migrations.
- Grow the system in layers. Start from the smallest version that works end to end, and add each new capability on top of a product that already works. Never trade a working product for unfinished complexity.
- Keep components modular and concerns clearly separated.
- Prefer established, well-maintained libraries when they reduce overall complexity or improve reliability. Do not reimplement common functionality without a clear reason.
- Do not assume a library lacks a capability without checking its documentation and types.
- Make architectural decisions for the long term. Stopgaps are allowed only when marked with a ponytail `shortcut: <the limit>, <when to upgrade>` comment.
- Study how established products solve the problem before designing a solution. Adopt their proven patterns and conventions rather than inventing an approach from scratch.
- NEVER, EVER, create comments that are narrative, always use the code itself to explain what is happening. Ponytail `shortcut:` comments are the exception.
- Remove all mannered prose.
- Use the `ponytail` skill (full level) on every coding task: writing, fixing, refactoring, reviewing, and choosing dependencies.
- Use the `writing-style` skill as the style guide for anything written in my voice: messages, PR and issue comments, posts, and drafts I'll send as myself.

## Start with what you need from me

When a long task is finished, or you're blocked and need my help, put any actions I need to take at the top of your reply.

Use a numbered list with one action per item. Explain what to do, where to do it, and what to send back when finished.

Example: "Log in to Railway, copy the production `DATABASE_URL` from the api service, and paste it here."

Put the biggest blocker first. If you need nothing from me, say so.

## Commits and PRs
- Never add AI attribution: no Co-Authored-By trailers for Claude/AI, no "Generated with Claude Code", no robot emoji signatures, in commit messages, PR titles/bodies, or comments. Do not copy such trailers from older commits.
- When `git commit` fails with `No private key found for public key`, the machine has no signing key. Never commit unsigned or turn signing off. Create the branch on GitHub if it is missing, publish the staged changes with the GraphQL `createCommitOnBranch` mutation through `gh api graphql` (GitHub signs it), then `git fetch` and `git reset --soft origin/<branch>`.
