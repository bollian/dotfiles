#!/bin/sh

repo_dir=$(dirname "$0")

# safe link w/ recursive directory creation
slnr() {
    target=$repo_dir/$1
    link=$HOME/$2

    if [ -s "$link" ]; then
        echo "'$2' already linked"
    elif [ -e "$link" ]; then
        echo "Not able to create config file '$2': Already exists." >&2
    else
        mkdir -p `dirname "$link"` # create any directories leading to the link file
        ln -s "$target" "$link"
    fi
}

slnr dotfiles/.bashrc .bashrc
slnr dotfiles/.config/bash .config/bash
slnr dotfiles/.config/git .config/git
slnr dotfiles/.config/nvim .config/nvim
slnr dotfiles/.hgrc .hgrc

