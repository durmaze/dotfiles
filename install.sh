#!/bin/sh


brew bundle --file=macos/Brewfile

stow backgrounds
stow bash
stow conky
stow curl
stow fonts && fc-cache
stow gcalcli
stow git
stow macos
stow mutt
stow neofetch
stow newsboat
stow nitrogen
stow ranger
stow sxhkd
stow sxiv
stow termite
stow tmux
stow vifm
stow vim
stow zathura
stow zsh
