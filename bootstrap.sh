#!/usr/bin/env bash
#
# bootstrap dotfiles

declare -r ROOT=$(cd "`dirname "$0"`" && pwd)

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
    success 'found gitconfig'
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

wget_file () {
  out=$(wget "$1" -O "$2" 2>&1)
  if [ 0 -eq $? ]; then
    success "downloaded $1 to $2"
  else
    fail "error downloading $1 to $2: $out"
  fi
}


switch_to_fish() {
  if [[ "$SHELL" = *fish ]]; then
    success "using fish"
  else
    user "switch to fish? (recommended) [ynq] "
    read -n 1 choise
    case "$choise" in
      y )
        info "switching to fish"
        chsh -s `which fish`
        ;;
      q )
        exit
        ;;
      * )
        info "skipping fish"
        ;;
    esac
  fi
}

install_tpm() {
  if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    success "found tpm"
  else
    user "install tpm? [ynq] "
    read -n 1 choise
    case "$choise" in
      y )
        info "installing tpm"
        mkdir -p "$HOME/.tmux/plugins"
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        ;;
      q )
        exit
        ;;
      * )
        info "skipping tmp, you will need to change ~/.tmux.conf"
        ;;
    esac
  fi
}

install_vim_neobundle() {
  if [ -d "$HOME/.vim/bundle/neobundle.vim" ]; then
    success "found neobundle"
  else
    user "install neobundle? [ynq] "
    read -n 1 choise
    case "$choise" in
      y )
        info "installing nebundle"
        mkdir -p "$HOME/.vim/bundle"
        git clone https://github.com/Shougo/neobundle.vim "$HOME/.vim/bundle/neobundle.vim"
        mkdir -p "$HOME/.vim/backups"
        ;;
      q )
        exit
        ;;
      * )
        info "skipping neobundle, you will need to change ~/.vimrc"
        ;;
    esac
  fi
}

install_autojump() {
  if [ -d "$HOME/.autojump/" ]; then
    success "found autojump"
  else
    user "install autojump? [ynq] "
    read -n 1 choise
    case "$choise" in
      y )
        info "installing autojump"
        git clone https://github.com/joelthelion/autojump "$HOME/autojump"
        cd "$HOME/autojump"
        ./install.py
        cd -
        ;;
      q )
        exit
        ;;
      * )
        info "skipping autojump"
        ;;
    esac
  fi
}

install_my_fish_config() {
  src="$ROOT/fish/config.fish"
  dest_dir="$HOME/.config/fish/"
  dest="${dest_dir}/config.fish"
  if [ ! -f "$src" ]; then
    fail "no source file $src"
    exit
  fi
  if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
  fi
  if [ -f "$dest" ]; then
    overwrite=false
    backup=false
    skip=false
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

setup_gitconfig
install_my_fish_config
switch_to_fish
install_autojump
install_vim_neobundle
install_tpm
install_dotfiles

echo 'done!'

