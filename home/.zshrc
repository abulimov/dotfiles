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
bin_paths=("$GOPATH/bin" "$HOME/.local/bin")

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

# added by travis gem
[ -f /Users/abulimov/.travis/travis.sh ] && source /Users/abulimov/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
