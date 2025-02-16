# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#

fpath=( "$HOME/.zfunctions" $fpath )

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
    git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# source antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# enable prompt
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# zsh-users/zsh-history-substring-search keybindings
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Customize to your needs...
#
# alias vim to nvim if we have it installed
if command -v nvim >/dev/null 2>&1; then
    EDITOR=nvim
    alias vim=nvim
else
    EDITOR=vim
fi
export GOPATH="$HOME/go/"
local -a python_paths
local -a bin_paths
bin_paths=("/snap/bin" "$GOPATH/bin" "$HOME/.local/bin" "$HOME/.local/ltex-ls-16.0.0/bin")

for p in $python_paths; do
    if [ -d "$p" ]; then
       export PYTHONPATH="$p:$PYTHONPATH"
    fi
done

for p in $bin_paths; do
    if [ -d "$p" ]; then
        export PATH="$p:$PATH"
    fi
done

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
