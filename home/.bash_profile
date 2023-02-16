#!/usr/bin/env bash
#
# Bash Profile
#
#
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Load stashed environment files located at the home directory
if [[ -a ~/.localrc ]]
then
    source ~/.localrc
fi
