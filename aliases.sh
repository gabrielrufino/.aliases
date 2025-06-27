# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias home="cd ~"
alias downl="cd ~/Downloads"
alias docs="cd ~/Documents"

# Git
alias clean_branches='git branch | grep -v "$(git branch --show-current)" | xargs git branch -D'
alias git_diff_to_clipboard="git diff --cached | xclip -selection clipboard"

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

# Others
alias awslocal='aws --endpoint-url=http://localhost:4566 --profile=localstack'

update_packages() {
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
}
