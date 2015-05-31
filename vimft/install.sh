#!/bin/bash
#
# Install .vim/ftplugins
#

set -e

echo $(dirname $0)

find `pwd` -name "*.vim" -print0 | xargs -0 -I{} ln -s {} ~/.vim/ftplugin/
