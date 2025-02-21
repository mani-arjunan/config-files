if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
  docker
  zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh
alias vim="nvim"
export PATH=$PATH:/opt/homebrew/bin
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

#bindings
bindkey -s ^f "~/fzf_open.sh\n"
bindkey -s ^q "~/fzf_queries.sh\n" 

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# load alias
source ~/alias

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
