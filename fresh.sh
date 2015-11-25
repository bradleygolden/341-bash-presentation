#!bin/bash

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Install fonts
brew tap caskroom/fonts

# Set path to use new binaries
echo export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH" >> ~/.bash_profile

brew cleanup

# Binaries
binaries=(
  python
  node
  git
  mercurial
  vim
  macvim --overide-system-vim
  tmux
  mackup
  zsh
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

# Restore previous configurations using mackup
mackup restore

# Configure zsh
sudo mv /etc/zshenv /etc/zprofile
cat /etc/shells | grep zsh || which zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)

# Configure git
# Write settings to ~/.gitconfig
git config --global user.name 'Bradley Golden'
git config --global user.email 'golden.bradley@gmail.com'

# a global git ignore file:
git config --global core.excludesfile '~/.gitignore'
echo '.DS_Store' >> ~/.gitignore

# use keychain for storing passwords
git config --global credential.helper osxkeychain

# you might not see colors without this
git config --global color.ui true

# Create development environment
mkdir ~/Development

# Clone all relevant repos into Dev folder
# TODO

# Apps
apps=(
  google-chrome
  flash
  silverlight
  vlc
  dash
  slack
  spotify
  iterm2
  atom
  microsoft-office
  amazon-music
  flux
  kindle
  dash
  java
  android-studio
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}


