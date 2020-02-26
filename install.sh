#!/bin/sh

echo "Configuring nvim..."
mkdir -p ~/.config/nvim
ln -s -f ~/dotfiles/.config/nvim/init.vim ~/.config/nvim
sudo pip install neovim 
echo "done"

echo "Configuring fonts..."
mkdir -p ~/.fonts 1>> /dev/null 2>> /dev/null
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete.ttf?raw=true -O ~/.fonts/Fantasque.ttf
echo "done"

echo "Creating .vim directory..."
mkdir ~/.vim
echo "done"

echo "installing Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "done"

echo "Installing Plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "done"

echo "Installing oh-my-zsh..."
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "done"

echo "Installing powerlevel10k theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
echo "done"

echo "Installing zsh syntax highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "done"

echo "Installing YAY"
git clone https://aur.archlinux.org/yay.git /tmp/yay
dir=$(pwd)
cd /tmp/yay
makepkg -si
cd $dir
echo "done"

echo "Creating links..."
for entry in $(cat files.rc); do                                                      
    target=$(echo $entry | cut -d";" -f1)                                            
    location=$(echo $entry | cut -d";" -f2)                                          
    echo $target to $location                                                        
    ln -s -T --suffix=$($pwd)/backup --backup=simple  "$(pwd)/$target" $HOME/$location     
done
echo "done"
