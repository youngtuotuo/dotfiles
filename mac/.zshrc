autoload -Uz compinit && compinit
bindkey -e
bindkey \^U backward-kill-line
export WORDCHARS="_"
autoload -U select-word-style
select-word-style bash

export EDITOR="nvim"
alias ls="ls -G"
alias ll='ls -hAlFG'
alias l="ls -lCFG"
alias la="ls -AG"
alias cl="clear"
alias vi="nvim"
alias taunt='echo "σ\`∀´)σ"'
echo "σ\`∀´)σ"

# export VIRTUAL_ENV_DISABLE_PROMPT=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
