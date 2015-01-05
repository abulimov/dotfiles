# Theme
set fish_theme lazywolf

# Disable greeting
set fish_greeting
set -u GREP_OPTIONS

set -U SSH_ENV $HOME/.ssh/environment

. $HOME/dotfiles/fish/lazywolf_theme.fish

if [ -f $SSH_ENV ]
  . $SSH_ENV > /dev/null
end
kill -0 $SSH_AGENT_PID > /dev/null
if [ $status -ne 0 ]
  echo "Initializing new SSH agent ..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  echo "succeeded"
  chmod 600 $SSH_ENV
  . $SSH_ENV > /dev/null
end

if test -e ~/.autojump/etc/profile.d/autojump.fish
  . ~/.autojump/etc/profile.d/autojump.fish
end

set -U -x GEM_PATH "$HOME/.gem"

set -U -x PYTHONPATH "$HOME/ansible-lint/lib" "$HOME/pelican-plugins"
set -U fish_user_paths "$HOME/ansible-lint/bin" "$HOME/.local/bin" "$GEM_PATH/bin"
