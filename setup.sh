#!/bin/sh

# Note: the dotfiles repo must be located at $HOME/dotfiles for this script to work properly

# safe link w/ recursive directory creation
slnr() {
    target=$HOME/dotfiles/$1
    link=$HOME/$2

    if [ -h "$link" ]; then
        echo "'$2' already linked"
    elif [ -e "$link" ]; then
        echo "Not able to create config file '$2': Already exists." >&2
    else
        mkdir -p `dirname "$link"` # create any directories leading to the link file
        ln -s "$target" "$link"
    fi
}

# cd into home directory
cd

slnr .bashrc      .bashrc
slnr .config/bash .config/bash
slnr .config/git  .config/git
slnr .config/nvim .config/nvim
slnr .hgrc        .hgrc
slnr .ssh/config  .ssh/config

