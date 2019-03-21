#!/bin/sh

lnr() {
	mkdir -p `dirname "$2"` || true
	ln -sf `pwd`/"$1" "$2"
}

# change to user directory
cd

lnr dotfiles/.bashrc .bashrc
lnr dotfiles/.config/bash .config/bash
lnr dotfiles/.config/git .config/git
lnr dotfiles/.config/nvim .config/nvim
lnr dotfiles/.hgrc .hgrc

