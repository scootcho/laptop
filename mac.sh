#!/bin/sh

# # Useful links
# http://sourabhbajaj.com/mac-setup/
# https://gist.github.com/zenorocha/7159780
# https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x


# Install Homebrew
echo "==================="
echo "Installing Homebrew"
echo "==================="
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update


# Installing required packages
echo "==================="
echo "Installing Essential Packages"
echo "==================="
brew install \
  wget \
  curl \
  git \

echo "brew list"
brew list


# Setting up Git
echo "==================="
echo "Setting up Git"
echo "==================="
echo 'export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"' >> ~/.bash_profile

IFS= read -r -p "Enter your git user name and press [ENTER]: " user_name
git config --global user.name "$user_name"
IFS= read -r -p "Enter your git user email and press [ENTER]: " user_name
git config --global user.email $user_email
git config --global core.excludesfile '~/.gitignore'
echo '.DS_Store' >> ~/.gitignore

# Unix/Mac
git config --global core.autocrlf input
git config --global core.safecrlf true
# # Windows
# git config --global core.autocrlf true
# git config --global core.safecrlf true


# Setting up Oh-my-zsh
echo "==================="
echo "Setting up Oh-my-zsh"
echo "==================="
brew install zsh zsh-completions
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
chsh -s /usr/local/bin/zsh

cat <<'EOT' >> ~/.zshrc
ZSH_THEME="agnoster"

plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting)

# Add env
source ~/.env
EOT

cat <<'EOT' >> ~/.env
#!/bin/zsh

# PATH
export PATH="/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR=vim

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'

# Use sublimetext for editing config files
# alias zshconfig="subl ~/.zshrc"
EOT


# Setting up scm-breeze
echo "==================="
echo "Setting up scm-breeze"
echo "==================="
git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
~/.scm_breeze/install.sh
source ~/.zshrc
# source ~/.bashrc

# Install x-code
echo "==================="
echo "Setting up x-code"
echo "==================="

touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
PROD=$(softwareupdate -l |
  grep "\*.*Command Line" |
  head -n 1 | awk -F"*" '{print $2}' |
  sed -e 's/^ *//' |
  tr -d '\n')
softwareupdate -i "$PROD" -v;


# Install Chruby & ruby-install
# http://ryanbigg.com/2015/06/mac-os-x-ruby-ruby-install-chruby-and-you/
echo "==================="
echo "Installing Chruby & Ruby"
echo "==================="
if ! [ -x "$(command -v chruby)" ]; then
  brew install chruby ruby-install
  ruby-install --latest ruby
  source /usr/local/opt/chruby/share/chruby/auto.sh
  source ~/.zshrc
fi

echo "Installing Bundler"
gem install bundler


# Installing PostgreSQL
echo "==================="
echo "Installing PostgreSQL"
echo "==================="
if ! [ -x "$(command -v psql)" ]; then
  brew install postgresql
fi


# Installing Mongodb
echo "==================="
echo "Installing Mongodb"
echo "==================="
brew install mongodb --with-openssl

cat <<'EOT' >> ~/.zshrc

# mongodb setup
export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin
EOT


# Installing NVM
echo "==================="
echo "Installing NVM"
echo "==================="
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
source ~/.zshrc

# Installing NodeJS
echo "==================="
echo "Installing NodeJS"
echo "==================="
nvm install 5.0
nvm use 5.0


# Set global NPM
echo "==================="
echo "Set global NPM"
echo "==================="
sh ./global_npm.sh


# Installing Packages & Applications
echo "==================="
echo "Installing Packages & Applications"
echo "==================="

echo "checking Brewfile"
brew bundle check
echo "Install missing brew bundle"
brew bundle


# Configuring Sublime Text 3
echo "==================="
echo "Configuring Sublime Text 3 and packages"
echo "==================="

ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

wget https://packagecontrol.io//Package%20Control.sublime-package --directory-prefix ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

cp ./sublime_settings/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
cp ./sublime_settings/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings

subl 
