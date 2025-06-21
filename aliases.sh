alias awslocal='aws --endpoint-url=http://localhost:4566 --profile=localstack'

alias git_diff_to_clipboard="git diff | xclip -selection clipboard"

update_packages() {
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
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
