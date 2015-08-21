#!/usr/bin/env bash

#
# Install my programs! :)
# -----------------------------------------------------------------------------
# Description: This scripts install my basic programs that I use day-by-day;
#              It has a lot of useful programs that I recommend. This list
#              will increase with time.
#              Any suggestion are accepted. :-) Send to dmztheone@gmail.com
#
# -- Last updated: 08-21-2015
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

# Python Programs
pip install -U cvskit --user
pip install -U supervisor --user

# Vim Programs
# Syntastic (manual installation) >> https://github.com/dmoliveira/syntastic#installation
