#!/bin/sh

for file in $(ls -a ~/dotfiles | grep -v "git"); do ln -s -f ~/dotfiles/$file ~/; done
