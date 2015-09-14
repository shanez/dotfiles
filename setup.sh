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
	brew cask install iterm2 docker-machine dockertoolbox docker-compose dash cloud divvy google-chrome skype transmission spotify alfred sublime-text xscope slack skitch toggldesktop dropbox disk-inventory-x bee
}

zshell ()
{
	echoName "ZShell"

	# Install ZSH
	brew install zsh
	chsh -s /bin/zsh

	# OMG-ZShell
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# Copy ZSH files
	# @TODO
}

preferences ()
{
	echoName "Preferences"

	# Copy XCode preferences
	cp init/com.apple.dt.Xcode.plist ~/Library/Preferences/com.apple.dt.Xcode.plist
	cp -r init/FontAndColorThemes ~/Library/Developer/Xcode/UserData/FontAndColorThemes

	# Copy Sublime preferences
	cp init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings init/Preferences.sublime-settings

	# Install Watchdog / Hues
	# @TODO
}

defaultFolders ()
{
	echoName "Creating Default Folders"

	mkdir ~/Code
	mkdir ~/git

	git clone gh:chriskempson/tomorrow-theme.git ~/git/
}

openApps ()
{
	echoName "Opening Apps"

	# Open programs to finalize setup
	open ~/Applications/Skype.app
	open ~/Applications/CloudApp.app
	open ~/Applications/Divvy.app
	open ~/Applications/Slack.app
	open ~/Applications/TogglDesktop.app
	open ~/Applications/Dropbox.app
	open ~/Applications/Spotify.app
	open ~/Applications/Alfred\ 2.app
}

hotcorners ()
{
	gsettings set org.pantheon.desktop.gala.behavior hotcorner-topright 'window-overview'
	# gsettings set org.pantheon.desktop.gala.behavior hotcorner-bottomleft 'window-hide'
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

	# Alert that we should commit / update
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	echo "Changes have been made.  Please commit"
	echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
}

# Read command line arguments and call function name
if [ -z "$1" ]
then
	setup
else
	$@
fi
