#!/usr/bin/env bash
# Installs pfstack into Claude Code and Codex.
#   ./install.sh            everything
#   ./install.sh --skills   only pfstack's own skills
#   ./install.sh --deps     only the external skills in skills.txt
#   ./install.sh --config   only AGENTS.md and the memory hook
# Existing files are moved to <file>.bak-<timestamp> before being replaced. Settings files are never touched.
set -euo pipefail

root=$(cd "$(dirname "$0")" && pwd)
stamp=$(date +%Y%m%d-%H%M%S)
what=${1:-all}

link() {
  local src=$1 dst=$2
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    mv "$dst" "$dst.bak-$stamp"
    echo "backed up $dst"
  fi
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

install_skills() {
  for dir in "$root"/skills/*/; do
    name=$(basename "$dir")
    link "${dir%/}" "$HOME/.agents/skills/$name"
    link "$HOME/.agents/skills/$name" "$HOME/.claude/skills/$name"
  done
}

install_deps() {
  grep -vE '^\s*(#|$)' "$root/skills.txt" | while read -r source skills; do
    args=()
    for s in $skills; do args+=(--skill "$s"); done
    npx -y skills add "$source" -g -y "${args[@]}" </dev/null
  done
}

install_config() {
  link "$root/AGENTS.md" "$HOME/.claude/CLAUDE.md"
  link "$root/AGENTS.md" "$HOME/.codex/AGENTS.md"
  link "$root/hooks/agent-memory.sh" "$HOME/.claude/hooks/agent-memory.sh"
  echo "Merge config/claude/settings.example.json and config/codex/*.example by hand; install.sh never writes settings."
}

case $what in
  all) install_skills; install_deps; install_config ;;
  --skills) install_skills ;;
  --deps) install_deps ;;
  --config) install_config ;;
  *) echo "unknown option: $what" >&2; exit 1 ;;
esac
