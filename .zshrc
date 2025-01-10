if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# ZSH Theme
ZSH_THEME="robbyrussell"

# Plugins for Oh-My-zsh
plugins=(
	git
	zsh-autosuggestions
)

#Oh-my-zsh
source $ZSH/oh-my-zsh.sh

#Aliases
alias vim="nvim"

#NVM shell
export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh
