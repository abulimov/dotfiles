# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme lazywolf

# Disable greeting
set fish_greeting

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
# set fish_plugins autojump

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

if test -e ~/.autojump/etc/profile.d/autojump.fish
    . ~/.autojump/etc/profile.d/autojump.fish
end

set -x GEM_PATH "$HOME/.gem"

set python_paths "$HOME/ansible-lint/lib" "$HOME/pelican-plugins"
set bin_paths "$HOME/ansible-lint/bin" "$HOME/.local/bin" "$GEM_PATH/bin"

for p in $python_paths
    if test -d "$p"
        set -x PYTHONPATH "$p" $PYTHONPATH
    end
end

for p in $bin_paths
    if test -d "$p"
        set -x PATH "$p" $PATH 
    end
end
