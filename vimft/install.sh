#!/bin/bash
#
# Install .vim/ftplugins
#

set -e

[ -d "$HOME/.vim/ftplugin" ] || mkdir -p "$HOME/.vim/ftplugin"

find `pwd` -name "*.vim" -print0 | xargs -0 -I{} ln -f -s {} ~/.vim/ftplugin/
ln -s -f $HOME/.vim $HOME/.nvim
