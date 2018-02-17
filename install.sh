#!/bin/sh

echo "Creating links..."
for file in $(ls -a ~/dotfiles | grep -v "git"); do ln -s -f ~/dotfiles/$file ~/; done
echo "done"

echo "Creating .vim directory..."
mkdir ~/.vim
echo "done"

echo "installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "done"

echo "Installing Plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim<Paste>
echo "done"

echo "Installing oh-my-zsh"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo "done"

echo "Installing powerlevel9k theme"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo "done"
