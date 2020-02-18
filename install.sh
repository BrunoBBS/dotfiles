#!/bin/sh

echo "Configuring nvim..."
mkdir -p ~/.config/nvim 1>> /dev/null 2>> /dev/null
ln -s -f ~/dotfiles/.config/nvim/init.vim ~/.config/nvim 1>> /dev/null 2>> /dev/null
sudo pip install neovim 1>> /dev/null 2>> /dev/null
echo "done"

echo "Configuring fonts..."
mkdir -p ~/.fonts 1>> /dev/null 2>> /dev/null
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete.ttf?raw=true -o ~/.fonts/Fantasque.ttf 1>> /dev/null 2>> /dev/null
echo "done"

echo "Creating .vim directory..."
mkdir ~/.vim 1>> /dev/null 2>> /dev/null
echo "done"

echo "installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 1>> /dev/null 2>> /dev/null
echo "done"

echo "Installing Plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 1>> /dev/null 2>> /dev/null
echo "done"

echo "Installing oh-my-zsh..."
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - 1>> /dev/null 2>> /dev/null)" 1>> /dev/null 2>> /dev/null
echo "done"

echo "Installing powerlevel10k theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k 1>> /dev/null 2>> /dev/null
echo "done"

echo "Creating links..."
for file in $(ls -a ~/dotfiles | grep -v "git"); do ln -s -f ~/dotfiles/$file ~/; done 1>> /dev/null 2>> /dev/null
echo "done"

echo "Post Cleanng...."
rm ~/install.sh 1>> /dev/null 2>> /dev/null
rm ~/README.md 1>> /dev/null 2>> /dev/null
echo "done"
