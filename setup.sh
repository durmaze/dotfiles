# install pacman packages
sudo pacman -S --needed - < pkglist.txt

# install tmux plugin manager
[[ ! -d ~/.tmux/plugins/tpm ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install AUR packages
yay -S --needed --noconfirm - < pkglist-aur.txt
