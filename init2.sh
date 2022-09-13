PROFILE=~/.bash_profile

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo_to_profile() {
    [ ! -z $(tail -c 1 $PROFILE) ] && echo "" >> $PROFILE
    echo $1 >> $PROFILE
    . $PROFILE
}

echo_present() {
    echo -e "${GREEN}🆗 $1 ${NC}"
}

echo_added() {
    echo -e "${GREEN}✅ $1${NC}"
}

echo_before_install() {
    echo -en "${YELLOW}   ⏳ $1 ${NC}"
}

echo_after_install() {
    echo -e \\r"${GREEN}   ✅ $1 ${NC}"
}



########################## Git ##########################

if [ ! -z $JD_GIT_SETUP ];
then
    echo_present "Git has already been setup"
else 
    echo "Setting up git..."
    echo -n '' "Git full name: "
    read git_name

    echo -n '' "Git email: "
    read git_email

    git config --global user.name $git_name
    git config --global user.email $git_email

    echo_to_profile "export JD_GIT_SETUP=true"
fi


########################## Brew ##########################

if [ ! -z $JD_BREW_INSTALLED ];
then 
    echo_present "Brew is already installed"
else 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo_to_profile "export JD_BREW_INSTALLED=true"
    echo_added "Brew has been installed!"
    sleep 1
fi 




########################## Applications ##########################


if [ ! -z $JD_APPLICATIONS_ALREADY_INSTALLED ];
then
    echo_present "Applications have already been installed"
elif [ -z $JD_BREW_INSTALLED ];
then 
    echo_blocked "You need to install brew before installing the applications"
else 

    echo "Applications: General"
    applications_to_install=( 
        google-chrome
        turbo-boost-switcher
        docker
        microsoft-teams
        simplemind
        whatsapp
        dbeaver-community
        rectangle
        teamviewer
        aws-vpn-client
        caffeine
        postman
        google-cloud-sdk
        signal
        visual-studio-code
     )
    for i in "${applications_to_install[@]}"
    do
        echo_before_install $i
        brew install --cask $i > /dev/null 2>&1
        echo_after_install $i
    done

    echo "Applications: Extras"
    echo_before_install "vscode extensions"
    xargs < vscode/extensions.list -n 1 code --install-extension > /dev/null 2>&1
    echo_after_install "vscode extensions"

    echo_before_install "vscode Settings"
    rm ~/Library/Application\ Support/Code/User/settings.json; 
    cp ./vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    echo_after_install "vscode Settings"
    

    echo_to_profile "export JD_APPLICATIONS_ALREADY_INSTALLED=true"
fi


########################## Terminal Stuff ##########################

if [ ! -z $JD_TERMINAL_APPS_ALREADY_INSTALLED ];
then
    echo_present "Terminal stuff has already been installed"
elif [ -z $JD_BREW_INSTALLED ];
then
    echo_blocked "You need to install brew before installing terminal stuff"
else 
    echo "Terminal Installs: General"
    terminal_installs=(
        watch
        alembic
        postgresql
        neovim
        bash-completion
        stripe/stripe-cli/stripe
        node@16
        pyenv
    )

    for i in "${terminal_installs[@]}"
    do
        echo_before_install $i
        brew install $i > /dev/null 2>&1
        echo_after_install $i
    done

    echo "Terminal Installs: Special"


    echo_before_install "xcode"
    xcode-select --install > /dev/null 2>&1
    echo_after_install "xcode"

    echo_before_install "linking node@16 to node"
    brew link --overwrite node@16 > /dev/null 2>&1
    echo_after_install "linking node@16 to node"
    
    echo_to_profile "export JD_TERMINAL_APPS_ALREADY_INSTALLED=true"
fi




########################## Screenshot Location ##########################

[ -d "~/Pictures/Screenshots" ] && mkdir ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots
echo_added "Screenshots location updated!"


########################## Screenshot Location ##########################

cp -r ./ssh/ ~/.ssh/
chmod 600 ~/.ssh/id_rsa
echo_added "SSH keys added!"


########################## Screenshot Location ##########################

cp -r ./._addons/ ~/._addons/
sed -i '' '/_addons/d' ${PROFILE}
echo_to_profile ". ~/._addons/script.sh"
echo_to_profile ". ~/._addons/patagona.sh"
. ${PROFILE}


# Tutorial
# https://medium.com/@timleland/how-to-enable-autocomplete-in-mac-terminal-f3480678e829
echo "set completion-ignore-case on" > ~/.inputrc
echo "set show-all-if-ambiguous on TAB: menu-complete" >> ~/.inputrc

# Also do this
# https://stackoverflow.com/questions/81272/how-to-move-the-cursor-word-by-word-in-the-os-x-terminal

echo_added "Shell customized!"