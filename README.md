# Mac-M4-Pro-Setup

### This script is designed to setup MAC M4 Pro.

### You won't need Xcode to use Homebrew, but some of the software and components you'll want to install will rely on Xcode's Command Line Tools package.
``` xcode-select --install ```

## Install Brew
### Install Homebrew
``` /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ```

### Set Path ( Note - Please change the username before use )
``` echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile" ```

### To check brew status
``` brew doctor ```

### Homebrew cask updater: https://github.com/buo/homebrew-cask-upgrade
``` brew tap buo/cask-upgrade ```

### install git
``` brew install git ```

### install Z-Shell
``` brew install zsh ```

## OH MY ZSH
### install
``` sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ```

### The installation script should set zsh to your default shell, but if it doesn't you can do it manually
``` chsh -s $(which zsh) ```

### To apply the changes you make you need to either start new shell instance or run
``` source ~/.zshrc ```

### zsh-syntax-highlighting
``` git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ```

### zsh-autosuggestions
``` git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions ```

### Enforce Changes
``` source ~/.zshrc ```

### install google chrome
``` brew install --cask google-chrome ```

### install node
``` brew install node ```

### install azure-data-studio
``` brew install --cask azure-data-studio ```

### install docker
``` brew install --cask docker ```

### install java
``` brew install openjdk ```

### install microsoft-azure-storage-explorer
``` brew install --cask microsoft-azure-storage-explorer ```

### install ngrok
``` brew install --cask ngrok ```

### install postman
``` brew install --cask postman ```

### install visual studio code
``` brew install --cask visual-studio-code ```

### install sublime-text
``` brew install --cask sublime-text ```

### install minikube
``` brew install minikube ```

### install terraform
``` brew install terraform ```

### install canva
``` brew install --cask canva ```



You can also display the app switcher on all monitors with the following undocumented preference:
```
defaults write com.apple.dock appswitcher-all-displays -bool true
killall Dock
```
This works on Monterey, Big Sur, Catalina, Mojave, and possibly older versions as well.
