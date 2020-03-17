#!/bin/bash

# Manual installation of neovim if zplug stops working
#
# Add the following to install.yaml.conf
# - shell:
#   - rm -rf neovim/binaries
#   - mkdir neovim/binaries
#   - [wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage,
#      Installing neovim binaries, update links as new releases come out]
#   - chmod u+x nvim.appimage
#   - mv nvim.appimage neovim/binaries/
#   - cd neovim/binaries && ./nvim.appimage --appimage-extract
#   - wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-macos.tar.gz
#   - mv nvim-macos.tar.gz neovim/binaries/
#   - cd neovim/binaries && tar -xvzf nvim-macos.tar.gz
#   - ./neovim/install_binaries.sh

# Add the followign to zshrc to use zplug to install neovim
# Install neovim from github releases
# The current gh-r command deletes the nvim binary from bin/
# and renames it to neovim in the top level repo dir
# Add a post hook build that copies it back to get around this
# zplug "neovim/neovim", \
#        from:gh-r, as:command, \
#        hook-build:'mv nvim-* nvim && \
#                    cp neovim nvim/bin/nvim && \
#                    ln -s ~/.zplug/repos/neovim/neovim/nvim/bin/nvim ~/.zplug/bin/nvim'

# Downlaod neovim from https://github.com/neovim/neovim/releases

LOCAL_PROG_PATH=$HOME/.local/bin
LOCAL_NVIM_PATH=$HOME/.local/bin/nvim
OSX_BINARY=binaries/nvim-osx64/bin/nvim
LINUX_BINARY=binaries/squashfs-root/AppRun

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	BINARY=$LINUX_BINARY
elif [[ "$OSTYPE" == "darwin"* ]]; then
	BINARY=$OSX_BINARY
fi

if [ -z "$BINARY" ]; then
    echo "Unable to determine host"
    exit 1
fi

echo "Using binary: $BINARY"

# Install nvim binary symlink in local bin
mkdir -p $LOCAL_PROG_PATH
rm -rf $LOCAL_NVIM_PATH
ABS_PATH=$(dirname $(readlink -f $0))
ln -s $ABS_PATH/$BINARY $LOCAL_NVIM_PATH
