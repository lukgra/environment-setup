export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Zoxide
eval "$(zoxide init zsh --cmd cd)"

# Eza
alias ls="eza -l --git --icons --group-directories-first"

# Zsh autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

. "$HOME/.local/bin/env"
