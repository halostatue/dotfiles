# Halostatue's Dotfiles

This repository contains a fairly extensive set of configuration for use on
my machines. After years of maintaining my own custom dotfiles manager in
[multiple] [incarnations], I’ve switched to dotfile management with
[Chezmoi].

This is part of a larger shift, where I have also shifted from zsh as my
shell of choice to fish. I’m getting most of the features I had from my zsh
configuration as fish functionality for a fraction of the startup time cost
and better overall usability. I will also be bringing my Vim configuration
in, but I am still building it out and will drop it in later (I am also
modernizing my Vim configuration and assuming Vim 8 or Neovim); part of this
is because the recently released Chezmoi 2.0 has _some_ support for Windows
should I ever find myself using Windows again.

## Prerequisites

- [Chezmoi] 2.0 or later
- [op], the 1Password CLI
- Data in [1Password] and the keyring (see `chezmoi secret keyring --help`).

## Installation

```sh
chezmoi init halostatue/chezmoi-dotfiles
```

## Inspirations

- https://github.com/ryanb/dotfiles
- https://github.com/henrik/dotfiles
- https://github.com/bkerley/zshkit
- https://github.com/mattfoster/zshkit
- https://github.com/robbyrussell/oh-my-zsh

## Other Things to Know

- https://git.herrbischoff.com/awesome-macos-command-line/about/

  - `~/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/ksinstall --nuke`

[multiple]: https://github.com/halostatue/ryanb-dotfiles-fork
[incarnations]: https://github.com/halostatue/zsh-focused-dotfiles
[chezmoi]: https://chezmoi.io
[op]: https://support.1password.com/command-line/
[1password]: https://1password.com/
