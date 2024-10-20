#!/bin/bash

# Update package list
sudo apt update

# Install necessary packages
sudo apt install -y build-essential cmake git curl neovim gcc-10 g++-10 \
    pkg-config x11-apps libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
    libxcb-render-util0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libegl-mesa0 \
    wget zsh tmux

# Install zsh plugin 
# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Install colored-man-pages
git clone https://github.com/ael-code/zsh-colored-man-pages.git ~/.zsh/zsh-colored-man-pages
echo "source ~/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh" >> ~/.zshrc

# Add the following lines to your .zshrc file

# Install Google Chrome if not already installed
if [ -x "$(command -v google-chrome-stable)" ]; then
    echo "Google Chrome is already installed."
else
    echo "Installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ./google-chrome-stable_current_amd64.deb
fi

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Ask about Qt installation
read -p "Do you want to install Qt? (y/n): " install_qt
if [[ $install_qt =~ ^[Yy]$ ]]; then
    echo "Installing Qt..."
    sudo apt install -y qtcreator qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
else
    echo "Skipping Qt installation."
fi

# Ask about FlatBuffers installation
read -p "Do you want to install FlatBuffers? (y/n): " install_flatbuffers
if [[ $install_flatbuffers =~ ^[Yy]$ ]]; then
    echo "Installing FlatBuffers..."
    git clone https://github.com/google/flatbuffers.git
    cd flatbuffers
    cmake -G "Unix Makefiles"
    make -j$(nproc)
    sudo make install
    cd ..
else
    echo "Skipping FlatBuffers installation."
fi

# Optionally, add more packages as needed
# sudo apt install -y <additional-package>

# Indicate completion
echo "Environment setup complete."cho "Environment setup complete."
