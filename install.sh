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
stow neomutt
stow newsboat
stow nitrogen
stow ranger
stow rtv
stow sxhkd
stow sxiv
stow synapse
stow termite
stow tmux
stow vifm
stow vim
stow zathura
stow zsh
