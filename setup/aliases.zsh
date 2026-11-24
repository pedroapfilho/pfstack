# Source from ~/.zshrc:  source ~/dev/pfstack/setup/aliases.zsh
alias up="softwareupdate -l && brew update && brew upgrade && brew cleanup && npm upgrade -g && npx skills update -g"
alias yolo="git add . && git commit --amend --no-edit && git push --force-with-lease"
alias lfg="claude -p 'Review my current branch and the most recent commit. Provide a detailed summary of all changes, including what was modified, added or removed. Analyze the overall impact and quality of the changes.'"
alias peek="claude -p 'Review my changes and give me your opinion, as a senior software engineer, on the quality and impact of the changes. Also, suggest any improvements or optimizations that could be made to the code.'"
