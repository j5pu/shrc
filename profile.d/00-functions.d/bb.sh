# shellcheck shell=sh

# brew all
bb() {
  brew update && brew upgrade && brew cleanup && brew autoremove && brew bundle dump --force && \
  brew bundle install --no-lock --cleanup && brew cleanup --prune=all
}
