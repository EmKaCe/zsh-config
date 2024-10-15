# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH Default settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# P10K
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Antidote
source /usr/share/zsh-antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# Keybinds
source $HOME/.config/zsh/key-bindings.zsh

# Set Browser env var
alias brave-browser='/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=brave --file-forwarding com.brave.Browser @@u %U @@'
export BROWSER=brave-browser

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# pnpm
export PNPM_HOME="/home/emre/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# batman
alias man='batman'

# yay / paru
alias paru='_paru_with_sudo'
alias yay='_paru_with_sudo'

function _paru_with_sudo() {
    if [ $# -eq 0 ]; then
        /usr/bin/paru -Syu --sudoloop --skipreview
    else
        /usr/bin/paru "$@" --sudoloop --skipreview
    fi
}

compdef _paru_with_sudo=paru


# tree
alias tree='eza -T --icons'
alias tre=tree

# Go
export PATH=$PATH:$HOME/go/bin

# calc
function calc() {
    # Replace x with * and ^ with ** for python
    echo $* | sed 's/x/*/g' | sed 's/\^/**/g' | python -c 'print(eval(input()))'
}
