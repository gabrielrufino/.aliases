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

update_apt_packages() {
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
}
