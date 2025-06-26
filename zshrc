autoload -Uz compinit && compinit
bindkey -e
bindkey \^U backward-kill-line
export WORDCHARS="_"
autoload -U select-word-style
select-word-style bash

alias vi="vim"
alias ls="ls -G"
alias ll='ls -hAlFG'
alias l="ls -lCFG"
alias la="ls -AG"
alias cl="clear"
echo "σ\`∀´)σ"
