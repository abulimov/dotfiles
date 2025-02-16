# My configuration files

## Installation

1. To get started, install [homeshick](https://github.com/andsens/homeshick) first.
2. Use the `homeshick` command to clone my castle:

  ```bash
  $ homeshick clone abulimov/dotfiles
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
     # WSL
     # helper = /mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe
  ```

4. Symlinks all dotfiles:

  ```bash
  $ homeshick link dotfiles
  ```

## Usage

```bash
$ homeshick
```
