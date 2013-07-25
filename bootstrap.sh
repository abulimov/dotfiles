#!/bin/bash

ROOT=$(pwd)

info () {
  printf " [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_files () {
  out=$(ln -s $1 $2 2>&1)
  if [ 0 -eq $? ]; then
    success "linked $1 to $2"
  else
    fail "error linking $1 to $2: $out"
  fi
}

switch_to_zsh() {
  if [[ "$SHELL" = *zsh ]]; then
    info "using zsh"
  else
    user "switch to zsh? (recommended) [ynq] "
    read -n 1 choise
    case "$choise" in
      y )
        info "switching to zsh"
        chsh -s `which zsh`
        ;;
      q )
        exit
        ;;
      * )
        info "skipping zsh"
        ;;
    esac
  fi
}
install_oh_my_zsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    info "found ~/.oh-my-zsh"
  else
    user "install oh-my-zsh? [ynq] "
    read -n 1 choise
    case "$choise" in
      y )
        info "installing oh-my-zsh"
        git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
        ;;
      q )
        exit
        ;;
      * )
        info "skipping oh-my-zsh, you will need to change ~/.zshrc"
        ;;
    esac
  fi
}
install_my_zsh_theme() {
  theme="$1"
  src="$ROOT/zsh/$theme.zsh-theme"
  target="$HOME/.oh-my-zsh/themes/$theme.zsh-theme"
  if [ ! -f "$src" ]; then
    fail "no source file $src"
    exit
  fi
  if [ -d "$HOME/.oh-my-zsh/themes" ]; then
    info "found ~/.oh-my-zsh/themes"
    if [ -f "$target" ]; then
      out=$(diff "$src" "$target" 2>&1)
      echo $out
      result=$?
      if [ 0 -eq "$result" ]; then
        info "found correct zsh theme"
      elif [ 1 -eq "$result" ]; then
        rm "$target"
        link_files "$src" "$target"
      else 
        fail "diff returned error with message $out"
      fi
    else
      link_files "$src" "$target"
    fi
  fi
}
install_oh_my_zsh
switch_to_zsh
install_my_zsh_theme "lazywolf"
#install_vim_files
#link_dotfiles

echo ''

