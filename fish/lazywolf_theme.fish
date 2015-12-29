# name: LazyWolf
# based on RobbyRussel
function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  if test $last_status = 0
      set arrow "$green➜ "
  else
      set arrow "$red➜ "
  end
  if test $CMD_DURATION
    # Show duration of the last command in seconds
    set -l duration (echo "$CMD_DURATION 1000" | awk '{printf "%.1fs", $1 / $2}')
    set arrow "$arrow($duration) "
  end
  set -l cwd $cyan(prompt_pwd)

  if [ (_git_branch_name) ]
    if [ (_is_git_dirty) ]
      set -l git_branch $yellow(_git_branch_name)
      set -l dirty "$yellow ✗ "
      set git_info "$blue git:($git_branch$blue)"
      set git_info "$git_info$dirty"
    else
      set -l git_branch $green(_git_branch_name)
      set git_info "$blue git:($git_branch$blue)"
    end
  end

  echo -n -s $arrow $cwd $git_info $normal ' '
end

function fish_right_prompt
  set_color $fish_color_autosuggestion ^/dev/null; or set_color 555
  date "+%H:%M:%S"
  set_color normal
end
