#
# Executes commands at the start of an interactive session.
#

fpath=( "$HOME/.zfunctions" $fpath )

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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
python_paths=("$HOME/github/pelican-plugins")
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
