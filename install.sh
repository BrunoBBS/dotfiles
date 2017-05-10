#!/bin/sh

for file in $(ls -a ~/dotfiles); do ln -s ~/dotfiles/$file ~/; done
