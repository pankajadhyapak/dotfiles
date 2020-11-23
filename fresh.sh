#!/bin/sh

echo "Setting up your Mac..."

sudo -v

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Set default MySQL root password and auth type.
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# # Install PHP extensions with PECL
# pecl install memcached imagick

# Install global Composer packages
/usr/local/bin/composer global require laravel/installer laravel/valet


# Create a Sites directory
# This is a default directory for macOS user accounts but doesn't comes pre-installed
mkdir $HOME/Documents/sites
mkdir $HOME/Documents/code
mkdir $HOME/Documents/gocode
mkdir $HOME/screenshots

git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/dotfiles/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/dotfiles/plugins/zsh-syntax-highlighting
touch ${HOME}/.hushlogin

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

# compaudit | xargs chmod g-w,o-w

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
