clear

# bash shell output color: https://stackoverflow.com/a/5947802/11717554
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo_red() {
    echo -e "${RED}$1${NC}"
}

echo_blocked() {
    echo -e "${RED}⛔️ $1${NC}"
}

echo_green() {
    echo -e "${GREEN}$1 ${NC}"
}

echo_added() {
    echo -e "${GREEN}✅ $1${NC}"
}

echo_present() {
    echo -e "${GREEN}🆗 $1 ${NC}"
}

echo_yellow() {
    echo -e "${YELLOW}$1${NC}"
}

echo_installing() {
    echo -e -n "" "${YELLOW}  ⏳ $1...${NC}"
}

echo_to_profile() {
    BASH_PROFILE=~/.bash_profile
    [ ! -z $(tail -c 1 $BASH_PROFILE) ] && echo "" >> $BASH_PROFILE
    echo $1 >> $BASH_PROFILE
    . $BASH_PROFILE
}

brew_cast_install() {
    echo_installing $1
    brew install --cask $1 > /dev/null 2>&1
    echo_added
}

brew_install() {
    echo_installing $1
    brew install $1 > /dev/null 2>&1
    echo_added
}

install_brew() {
    if [ ! -z $JD_BREW_INSTALLED ];
    then 
        echo_present "Brew is already installed"
        return
    fi 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo_to_profile "export JD_BREW_INSTALLED=true"
    echo_added "Brew has been installed!"
    sleep 1
}

install_applications() {
    if [ ! -z $JD_APPLICATIONS_ALREADY_INSTALLED ];
    then
        echo_present "Applications have already been installed"
        return
    fi

    if [ -z $JD_BREW_INSTALLED ];
    then 
        echo_blocked "You need to install brew before installing the applications"
        return
    fi 

    echo_yellow "⏳ Installing applications..."

    brew_cast_install visual-studio-code

    echo_installing "vscode extensions"
    xargs < vscode/extensions.list -n 1 code --install-extension > /dev/null 2>&1
    echo_added

    echo_installing "vscode Settings"
    rm ~/Library/Application\ Support/Code/User/settings.json; 
    cp ./vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    echo_added
    
    brew_cast_install google-chrome

    brew_cast_install turbo-boost-switcher

    brew_cast_install docker

    brew_cast_install whatsapp

    brew_cast_install dbeaver-community

    brew_cast_install rectangle

    brew_cast_install teamviewer

    brew_cast_install aws-vpn-client

    brew_cast_install expressvpn

    echo_to_profile "export JD_APPLICATIONS_ALREADY_INSTALLED=true"
}


setup_git() {
    if [ ! -z $JD_GIT_SETUP ];
    then
        echo_present "Git has already been setup"
        return
    fi


    echo -e "${YELLOW}Setting up git$NC"

    echo -n '' "Git full name: "
    read git_name

    echo -n '' "Git email: "
    read git_email

    git config --global user.name $git_name
    git config --global user.email $git_email
    
    echo_to_profile "export JD_GIT_SETUP=true"
}

install_terminal_stuff () {

    if [ ! -z $JD_TERMINAL_APPS_ALREADY_INSTALLED ];
    then
        echo_present "Terminal stuff has already been installed"
        return
    fi

    if [ -z $JD_BREW_INSTALLED ];
    then 
        echo_blocked "You need to install brew before installing terminal stuff"
        return
    fi 

    echo_yellow "⏳ Installing terminal stuff..."


    brew_install node@16
    
    echo_installing "linking node@16 to node"
    brew link --overwrite node@16 > /dev/null 2>&1
    echo_added
    
    echo_installing "xcode"
    xcode-select --install > /dev/null 2>&1
    echo_added
    
    brew_install pyenv

    echo_installing "python 3.9.2"
    pyenv install 3.9.2 > /dev/null 2>&1
    echo_added

    brew_install watch

    brew_install alembic

    brew_install postgresql

    echo_to_profile "export JD_TERMINAL_APPS_ALREADY_INSTALLED=true"
}

change_screenshots_location() {
    [ -d "~/Pictures/Screenshots" ] && mkdir ~/Pictures/Screenshots
    defaults write com.apple.screencapture location ~/Pictures/Screenshots
    echo_added "Screenshots location updated!"
}

setup_ssh_keys() {
    cp -r ./ssh/ ~/.ssh/
    echo_added "SSH keys added!"
}

customize_shell() {
    cp -r ./.bash_profile_addons/ ~/.bash_profile_addons/
    sed -i '' '/.bash_profile_addons/d' ~/.bash_profile
    echo_to_profile ". ~/.bash_profile_addons/script.sh"
    . ~/.bash_profile
    echo_added "Shell customized!"
}

setup_git
install_brew
install_applications
install_terminal_stuff
change_screenshots_location
setup_ssh_keys
customize_shell
