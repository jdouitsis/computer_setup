clear


# - Save ssh keys 
# - Have option to be able to run comp_script.sh from the network 
# - Then, what ever it needs it will just pull directly from whatever repository this is from. So it would do the origin pull and crap like that
# - Make the .bash_profile_addons be a symlink to this directory instead of actually copying it. That way it will much easier to edit and stuff
#   - If you do this with the network idea, make sure that all these files get saved in the root or something. Can't have it all in a random directory. Maybe at rootlevel? 

# VSCODE
# - Pull in all the extensions and stuff
# Make a simlink file for the settings file so it will live in this folder

install_applications() {
    echo "Installing vscode..."
    brew install --cask visual-studio-code
    
    echo "Installing chrome..."
    brew install --cask google-chrome

    echo "Installing Turbo Boost Switcher"
    brew install --cask turbo-boost-switcher

    echo "Installing docker..."
    brew install --cask docker

    echo "Installing whatsapp..."
    brew install --cask whatsapp

    echo "Installing dbeaver..."
    brew install --cask dbeaver-community

    echo "Installing alembic..."
    brew install alembic

    echo "Installing Postgress SQL..."
    brew install postgresql
}

install_terminal_stuff () {
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "Installing node 16..."
    brew install node@16
    brew link --overwrite node@16
    
    echo "Installing xcode stuff"
    xcode-select --install

    echo "Installing pyenv"
    brew install pyenv

    echo "Installing python 3.9.2"
    pyenv install 3.9.2

    echo "Installing watch..."
    brew install watch

}

change_screenshots_location() {
    mkdir ~/Pictures/Screenshots
    defaults write com.apple.screencapture location ~/Pictures/Screenshots
}

customize_shell() {
    ln -s ./.bash_profile_addons ~/.bash_profile_addons
    echo ". ~/.bash_profile_addons" >> ~/.bash_profile
}

show_git_aliases() {
    cat ~/.gitconfig
}
echo '''Available functions: 
- install_terminal_stuff()
- customize_shell()
- change_screenshots_location()
- install_applications()
- show_git_aliases()
'''