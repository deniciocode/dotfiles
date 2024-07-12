#!/bin/bash
echo "Hello World"

ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/gitignore ~/.gitignore
ln -s $(pwd)/zshrc ~/.zshrc

mkdir ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
ln -s $(pwd)/auto_switch_theme.py ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/auto_switch_theme.py
