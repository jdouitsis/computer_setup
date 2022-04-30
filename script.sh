clear

# bash shell output color: https://stackoverflow.com/a/5947802/11717554
RED='\033[0;31m'
NC='\033[0m' # No Color

echo_red() {
    echo -e "${RED}$1${NC}"
}

echo_to_profile() {
    BASH_PROFILE=~/.bash_profile
    [ ! -z $(tail -c 1 $BASH_PROFILE) ] && echo "" >> $BASH_PROFILE
    echo $1 >> $BASH_PROFILE
}

# - Save ssh keys 
# - Have option to be able to run comp_script.sh from the network 
# - Then, what ever it needs it will just pull directly from whatever repository this is from. So it would do the origin pull and crap like that
# - Make the .bash_profile_addons be a symlink to this directory instead of actually copying it. That way it will much easier to edit and stuff
#   - If you do this with the network idea, make sure that all these files get saved in the root or something. Can't have it all in a random directory. Maybe at rootlevel? 

# VSCODE
# - Pull in all the extensions and stuff
# Make a simlink file for the settings file so it will live in this folder

install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo_to_profile "export JD_BREW_INSTALLED=true"
}

install_applications() {

    if [ ! -z $JD_BREW_INSTALLED ];
    then 
        echo_red "You need to install brew before installing the applications"
        return
    fi 

    if [ -z $JD_APPLICATIONS_ALREADY_INSTALLED ];
    then
        echo_red "Applications have already been installed"
        return
    fi

    echo "Installing vscode..."
    brew install --cask visual-studio-code

    echo "Installing vscode extensions..."
    xargs < vscode/extensions.list -n 1 code --install-extension

    echo "Installing vscode Settings..."
    rm ~/Library/Application\ Support/Code/User/settings.json; 
    cp ./vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    
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

    echo "Installing Rectangle..."
    brew install --cask rectangle

    echo "Installing teamviewer..." 
    brew install --cask teamviewer

    echo "Installing AWS VPN Client..."
    brew install --cask aws-vpn-client

    echo_to_profile "export JD_APPLICATIONS_ALREADY_INSTALLED=true"
}

install_terminal_stuff () {

    if [ -z $JD_TERMINAL_APPS_ALREADY_INSTALLED ];
    then
        echo_red "Terminal apps already installed have already been installed"
        return
    fi

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

    echo "Installing alembic..."
    brew install alembic

    echo "Installing Postgress SQL..."
    brew install postgresql

    echo_to_profile "export JD_TERMINAL_APPS_ALREADY_INSTALLED=true"
}


change_screenshots_location() {
    mkdir ~/Pictures/Screenshots
    defaults write com.apple.screencapture location ~/Pictures/Screenshots
}

setup_ssh_keys() {
    cp -r ./ssh/ ~/.ssh/
}

customize_shell() {
    cp ./.bash_profile_addons ~/.bash_profile_addons
    sed -i '' '/bash_profile_addons/d' ~/.bash_profile
    echo_to_profile ". ~/.bash_profile_addons"
    clear
    . ~/.bash_profile
}

show_git_aliases() {
    cat ~/.gitconfig
}

backup() {
    echo "Backing up ssh..."
    pushd ssh
        cat ~/.ssh/config > config
        cat ~/.ssh/id_rsa > id_rsa
        cat ~/.ssh/id_rsa.pub > id_rsa.pub
    popd

    echo "Backing up vscode..."
    pushd vscode
        code --list-extensions > extensions.list
        cat ~/Library/Application\ Support/Code/User/settings.json > settings.json
    popd
}

# echo '''You need to install brew first by running: 
#     install_brew

# Then you can run:
#     install_terminal_stuff
#     install_applications

# Then other things you can do are:
#     customize_shell
#     change_screenshots_location
#     show_git_aliases
#     setup_ssh_keys
#     backup
# '''