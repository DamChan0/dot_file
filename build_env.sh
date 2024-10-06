#!/bin/bash

# Update package list
sudo apt update

# Install necessary packages
sudo apt install -y build-essential cmake git curl neovim gcc-10 g++-10 \
    pkg-config x11-apps libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
    libxcb-render-util0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libegl-mesa0 \
    wget zsh tmux qtcreator qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \

# google-chrome-stable이 없으면 설치
# Install Google Chrome
if [ -x "$(command -v google-chrome-stable)" ]; then
    echo "Google Chrome is already installed."
else
    echo "Installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ./google-chrome-stable_current_amd64.deb
fi

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Installing FlatBuffers..."
git clone https://github.com/google/flatbuffers.git
cd flatbuffers
cmake -G "Unix Makefiles"
make -j$(nproc)
sudo make install
cd ..

# Optionally, add more packages as needed
# sudo apt install -y <additional-package>

# Indicate completion
echo "Environment setup complete."
