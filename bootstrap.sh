#!/usr/bin/env bash
#
# bootstrap dotfiles

declare -r ROOT=`dirname $(readlink -f $0)`

zsh_theme="lazywolf"

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


setup_gitconfig () {
  if ! [ -f "$ROOT/git/gitconfig.symlink" ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.symlink.example > git/gitconfig.symlink

    success 'gitconfig'
  else
    info 'found gitconfig'
  fi
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
  dest="$HOME/.oh-my-zsh/themes/$theme.zsh-theme"
  if [ ! -f "$src" ]; then
    fail "no source file $src"
    exit
  fi
  if [ -d "$HOME/.oh-my-zsh/themes" ]; then
    info "found ~/.oh-my-zsh/themes"
    if [ -f "$dest" ]; then
      user "File already exists: `basename $src`, what do you want to do? [s]kip, [o]verwrite, [b]ackup?"
      read -n 1 action

      case "$action" in
        o )
          overwrite=true;;
        b )
          backup=true;;
        s )
          skip=true;;
        * )
          ;;
      esac
      if [ "$overwrite" == "true" ] 
      then
        rm -rf $dest
        success "removed $dest"
      fi

      if [ "$backup" == "true" ]
      then
        mv $dest $dest\.backup
        success "moved $dest to $dest.backup"
      fi

      if [ "$skip" == "false" ]
      then
        link_files $src $dest
      else
        success "skipped $src"
      fi
    else
      link_files "$src" "$dest"
    fi
  fi
}

install_dotfiles () {
  info 'installing dotfiles'
  overwrite_all=false
  backup_all=false
  skip_all=false

  for src in `find $ROOT -maxdepth 2 -name \*.symlink`
  do
    dest="$HOME/.`basename \"${src%.*}\"`"

    if [ -f $dest ] || [ -d $dest ]
    then
      overwrite=false
      backup=false
      skip=false

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
      then
        user "File already exists: `basename $src`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      then
        rm -rf $dest
        success "removed $dest"
      fi

      if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      then
        mv $dest $dest\.backup
        success "moved $dest to $dest.backup"
      fi

      if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
      then
        link_files $src $dest
      else
        success "skipped $src"
      fi
    else
      link_files $src $dest
    fi
done
}

install_oh_my_zsh
switch_to_zsh
install_my_zsh_theme "$zsh_theme"
install_dotfiles

echo 'done!'

