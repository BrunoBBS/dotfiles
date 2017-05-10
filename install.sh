#!/bin/sh

for file in $(ls -a ~/dotfiles); do ln -s -f ~/dotfiles/$file ~/; done
