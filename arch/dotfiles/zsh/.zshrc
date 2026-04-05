export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Zoxide
eval "$(zoxide init zsh --cmd cd)"

# Eza
alias ls="eza -l --git --icons --group-directories-first"

