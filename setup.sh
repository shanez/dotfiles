#!/bin/bash

echoName ()
{
	echo "------------------"
	echo $1
	echo "------------------"
}

brewCore ()
{
	echoName "Brew"

	# Install brew
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# Install brew cask
	brew install caskroom/cask/brew-cask
	brew install Caskroom/cask/java

	# Run default packages
	source ./brew.sh
}

brewApps ()
{
	echoName "Brewing Apps"

	# Install some needed apps
	brew cask install iterm2 docker-machine dockertoolbox docker-compose dash cloud divvy google-chrome skype transmission spotify alfred sublime-text xscope slack skitch toggldesktop dropbox disk-inventory-x bee tower textwrangler
}

zshell ()
{
	echoName "ZShell"

	# Install ZSH
	brew install zsh
	chsh -s /bin/zsh

	# OMG-ZShell
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

preferences ()
{
	echoName "Preferences"

	# Copy XCode preferences
	cp init/com.apple.dt.Xcode.plist ~/Library/Preferences/com.apple.dt.Xcode.plist
	cp -r init/FontAndColorThemes ~/Library/Developer/Xcode/UserData/FontAndColorThemes

	# Copy Sublime preferences
	cp init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings init/Preferences.sublime-settings
	# @TODO - Add Soda

	# Install Watchdog / Hues
	# @TODO

	# Copy ZSH Prefrences
	cp -r init/.oh-my-zsh ~/.oh-my-zsh
}

defaultFolders ()
{
	echoName "Creating Default Folders"

	mkdir ~/Code
	mkdir ~/git

	git clone https://github.com/chriskempson/tomorrow-theme.git ~/git/tomorrow-theme
}

openApps ()
{
	echoName "Opening Apps"

	# Open programs to finalize setup
	open ~/Applications/Divvy.app
}

copyDots ()
{
	source ./bootstrap.sh
}


setup ()
{
	echoName "Default Setup"

	sudo -v

	copyDots
	source .bashrc
	source .osx
	brewCore
	brewApps
	zshell

	# Add screenshots folder to the dock
	# @TODO

	# Add Google extensions
	# @TODO

	preferences
	defaultFolders
	openApps
}

copyPreferences ()
{
	echoName "Copy preferences"

	# Copy xCode preferences into repo
	cp -r ~/Library/Developer/Xcode/UserData/FontAndColorThemes init/FontAndColorThemes
	cp ~/Library/Preferences/com.apple.dt.Xcode.plist init/com.apple.dt.Xcode.plist

	# Copy Sublime preferences into repo
	cp ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings init/Preferences.sublime-settings

	# Copy ZSH Preferences
	cp -r ~/.oh-my-zsh init/.oh-my-zsh

	# Alert that we should commit / update
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Changes have been made.  Please commit"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
}

# Read command line arguments and call function name
if [ -z "$1" ]
then
	setup
else
	$@
fi
