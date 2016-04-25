# My configuration files

## Installation

1. To get started, install [homesick](https://github.com/technicalpickles/homesick) first:

  ```bash
  $ # optionally set up gemrc:
  $ touch ~/.gemrc && \
    echo 'gem: --user-install --no-document -n~/.local/bin' >> ~/.gemrc && \
    mkdir -p "$HOME/.local/bin" && \
    export PATH=$HOME/.local/bin:$PATH
  $ gem install homesick
  ```

2. Use the `homesick` command to clone my castle:

  ```bash
  $ homesick clone abulimov/dotfiles
  ```

3. Put your Git credentials into `~/.gitconfig.local`. For example:

  ```
  [user]
     name = Foo Example
     email = foo@example.com
  [credential]
     # OS X
	 helper = osxkeychain
     # Linux
     # helper = cache
  ```

4. Symlinks all dotfiles:

  ```bash
  $ homesick link dotfiles
  ```

5. Install dependencies and plugins:

  ```bash
  $ homesick rc --force dotfiles
  ```

## Usage

```bash
$ homesick
```

## Configuration files for

* [Atom](https://atom.io/) is a hackable text editor for the 21st Century

* [Git](http://git-scm.com) is a distributed version control system
 * [.gitconfig](home/.gitconfig)

* [Prezto](https://github.com/sorin-ionescu/prezto) is the configuration framework for [Zsh](http://www.zsh.org)
 * [.zshrc](home/.zshrc)
 * [.zpreztorc](home/.zpreztorc)

* [tmux](http://tmux.sourceforge.net) is a terminal multiplexer
 * [.tmux.conf](home/.tmux.conf)

* [Vim](http://www.vim.org) is a highly configurable text editor
 * [.vimrc](home/.vimrc)
