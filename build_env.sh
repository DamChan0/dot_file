#!/bin/bash

# Function to display menu and handle user input
function display_menu() {
    echo "================================"
    echo "Welcome to the Environment Setup Script"
    echo "Please choose options to install:"
    echo "1) ZSH"
    echo "2) Qt"
    echo "3) Default Install"
    echo "4) Exit"
    echo "================================"
    echo "Enter your choices one at a time."
}

# Function to install ZSH and related plugins
function install_zsh() {
    echo "Installing ZSH and plugins..."
    sudo apt install -y zsh

    # Install zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

    # Install zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
    echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

    # Install colored-man-pages
    git clone https://github.com/ael-code/zsh-colored-man-pages.git ~/.zsh/zsh-colored-man-pages
    echo "source ~/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh" >> ~/.zshrc

    echo "ZSH installation complete."
}

# Function to install Qt development environment
function install_qt() {
    echo "Installing Qt development environment..."
    sudo apt install -y qtcreator qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
    echo "Qt installation complete."
}

# Function to perform the default installation
function default_install() {
    echo "Performing default installation..."
    sudo apt install -y build-essential cmake git curl neovim gcc-10 g++-10 \
        pkg-config x11-apps libxcb-icccm4 libxcb-image0 libxcb-keysyms1 \
        libxcb-render-util0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon-x11-0 libegl-mesa0 \
        wget zsh tmux
    echo "Default installation complete."
}

# Function to process the queue
function process_queue() {
    local queue=("$@")
    for choice in "${queue[@]}"; do
        case $choice in
            1)
                install_zsh
                ;;
            2)
                install_qt
                ;;
            3)
                default_install
                ;;
            *)
                echo "Invalid choice in queue: $choice"
                ;;
        esac
    done
}

# Main function
function main() {
    local queue=()
    while true; do
        display_menu
        read -p "Your choice: " choice

        if [[ $choice -eq 4 ]]; then
            echo "Processing queued installations..."
            process_queue "${queue[@]}"
            echo "Exiting the script. Goodbye!"
            break
        fi

        if [[ $choice =~ ^[1-3]$ ]]; then
            queue+=("$choice")
            echo "Added choice $choice to the queue."
        else
            echo "Invalid choice: $choice"
        fi
    done
}

# Run the script
main
