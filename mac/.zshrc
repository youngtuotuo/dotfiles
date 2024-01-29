# User configuration
bindkey -e
bindkey \^U backward-kill-line

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# You may need to manually set your language environment

export EDITOR="nvim"
alias ls="ls -G"
alias ll='ls -hAlFG'
alias l="ls -lCFG"
alias la="ls -AG"
alias cl="clear"
alias vi="nvim"

fpath+=${ZDOTDIR:-~}/.zsh_functions

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
export VIRTUAL_ENV_DISABLE_PROMPT=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
echo "σ\`∀´)σ"
alias taunt='echo "σ\`∀´)σ"'
