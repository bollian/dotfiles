#!/bin/sh

# Note: the dotfiles repo must be located at $HOME/dotfiles for this script to work properly

# safe link w/ recursive directory creation
slnr() {
    target=$HOME/dotfiles/$1
    shift # discard $1 so we can loop through all arguments afterwards

    while test $# -gt 0; do
        link=$HOME/$1

        if [ -h "$link" ]; then
            echo "'$1' already linked"
        elif [ -e "$link" ]; then
            echo "'$1' already exists" >&2
        else
            mkdir -p $(dirname "$link") # create any directories leading to the link file
            ln -s "$target" "$link"
        fi

        shift # discard this argument
    done
}

# cd into home directory
cd

slnr .bashrc      .bashrc
slnr .gdbinit     .gdbinit
slnr .inputrc     .inputrc
slnr .config/bash .config/bash
slnr .config/git  .config/git
slnr .config/nvim .config/nvim
slnr .hgrc        .hgrc
slnr .ssh/config  .ssh/config
slnr .config/pijul/config.toml .config/pijul/config.toml

# reload so that systemd picks up any new services
systemctl --user daemon-reload
