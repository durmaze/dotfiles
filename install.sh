#!/bin/sh


brew bundle --file=macos/Brewfile

stow bash
stow curl
stow gcalcli
stow git
stow macos
stow mutt
stow newsboat
stow ranger
stow tmux
stow vim
stow zsh

