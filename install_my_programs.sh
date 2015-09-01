#!/usr/bin/env bash

#
# Install my programs! :)
# -----------------------------------------------------------------------------
# Description: This scripts install my basic programs that I use day-by-day;
#              It has a lot of useful programs that I recommend. This list
#              will increase with time.
#              Any suggestion are accepted. :-) Send to dmztheone@gmail.com
#
# -- Last updated: 09-01-2015
#
# ------------------------------------------------------------------------------
#

# Linux Programs
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install vim
sudo apt-get install vim-gnome
sudo apt-get install terminator
sudo apt-get install xclip
sudo apt-get install htop
sudo apt-get install wharfee
sudo apt-get install lynx-cur
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Python Programs
pip install -U cvskit --user
pip install -U supervisor --user
pip install -U flake --user

# Vim Programs
# Vundle Vim package management >> https://github.com/VundleVim/Vundle.vim
# Look at my ../run_commands/vimrc_mac
