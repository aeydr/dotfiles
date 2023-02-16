#!/bin/bash
echo Hello Gitpod
echo Here is my .bash_aliases dotfile

alias gitsha='git rev-parse HEAD'

current_dir="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
dotfiles_source="${current_dir}/.dotfiles"
while read -r file; do
    echo "${file}"
    #source "${file}"
done < <(find "${dotfiles_source}" -type f)