#!/bin/sh

echo "==================="
echo "Installing zsh-autosuggestions"
echo "==================="
# # Install zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

cat <<'EOT' >> ~/.zshrc

# Settings for zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Do not display username in commandline
DEFAULT_USER=`whoami`

EOT

source ~/.zshrc


echo "==================="
echo "Installing Tmuxinator"
echo "==================="
# # Install tmuxinator
# https://github.com/tmuxinator/tmuxinator
gem install tmuxinator

cat <<'EOT' >> ~/.zshrc

# tmuxinator
source ~/.bin/tmuxinator.zsh

EOT

source ~/.zshrc
