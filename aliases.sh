# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias home="cd ~"
alias downl="cd ~/Downloads"
alias docs="cd ~/Documents"

# Git
alias clean_branches='git branch | grep -v "$(git branch --show-current)" | xargs git branch -D'
alias copy_diff="git diff --cached | xclip -selection clipboard"
alias merge_branch='git branch --format="%(refname:short)" | fzf | xargs git merge'
alias select_branch='git branch --format="%(refname:short)" | fzf | xargs git checkout'
alias delete_branch='git branch --format="%(refname:short)" | fzf | xargs git branch -D'

compare_branches() {
  echo "Select first branch:"
  local branch1=$(git branch --format="%(refname:short)" | fzf --prompt="First branch: ")
  
  echo "Select second branch:"
  local branch2=$(git branch --format="%(refname:short)" | fzf --prompt="Second branch: ")

  echo ""
  echo "=== Commits in '$branch1' but not in '$branch2' ==="
  git log --oneline --no-merges "$branch2..$branch1"
}

update_repositories() {
  for dir in */ ; do
    if [ -d "$dir/.git" ]; then
      (
        cd "$dir" || exit
        git pull
      ) &
    fi
  done
  wait
}

# NPM
update_npm_packages() {
  npm update --save
  npm audit fix
  git add package.json package-lock.json
  git commit -m "chore: update npm packages"
  git push
}

# Others
alias awslocal='aws --endpoint-url=http://localhost:4566 --profile=localstack'

notify() {
  notify-send "Attention" "$1"
  paplay /usr/share/sounds/sound-icons/xylofon.wav
}

trash() {
  gio trash "$@"
}

update_apt_packages() {
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
}
