clear

'''
- Save ssh keys 

'''
install_softwares () {
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "Installing vscode..."
    brew install --cask visual-studio-code

    echo "Installing node 16..."
    brew install node@16
    brew link --overwrite node@16
    
    echo "Installing chrome..."
    brew install --cask google-chrome

    echo "Installing xcode stuff"
    xcode-select --install

    echo "Installing pyenv"
    brew install pyenv

    echo "Installing python 3.9.2"
    pyenv install 3.9.2

    echo "Installing Turbo Boost Switcher"
    brew install --cask turbo-boost-switcher

    echo "Installing docker"
    brew install --cask docker

    echo "Installing whatsapp"
    brew install --cask whatsapp

}

change_screenshots_location() {
    mkdir ~/Pictures/Screenshots
    defaults write com.apple.screencapture location ~/Pictures/Screenshots
}

customize_shell() {
    echo '''
#################    General Aliases    ################# 
#########################################################

alias r=". ~/.bash_profile"
alias gh="cd ~/Github"
alias c="clear"
alias l="ls -G -F"
alias la="l -a"


#######################    Git    ####################### 
#########################################################

git config --global alias.uc "reset HEAD~"
git config --global alias.c "commit"
git config --global alias.cm "commit -m"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.aa "!git a && git amend"
git config --global alias.st "status -sb"
git config --global alias.ll "log --oneline"
git config --global alias.se "!git rev-list --all | xargs git grep -F"
git config --global alias.ch "checkout"
git config --global alias.a "add . -A"

alias ga="git config --get-regexp alias"
alias gb="git rev-parse --abbrev-ref HEAD"

####################### Terminal ########################
#########################################################

# https://medium.com/@adamtowers/how-to-customize-your-terminal-and-bash-profile-from-scratch-9ab079256380
export PS1="\[\033[01;32m\]\u\[\033[01;34m\]\w\[\033[00m\]\n\$ "

# Removes the warning regarding the zsh shell
export BASH_SILENCE_DEPRECATION_WARNING=1


######################## Docker #########################
#########################################################

alias d="docker"

# Stop/rm containers/images/volumes
# alias dsc="docker container stop $(d container ls -a -q)"
# alias drmc="dsc; docker container rm $(d container ls -a -q)"
# alias drmv="docker volume rm $(d volume ls -q)"
# alias drmi="docker image rm -f $(d image ls -q)"
alias drma="dsc; drmc; drmv; drmi;"

#################### Docker Compose #####################
#########################################################

# Compose Viewing 
alias dcl="docker-compose logs -f "
alias dcps="watch -n 1 docker-compose ps"
alias dwc="watch -n 1 docker container ls "

dck() {
    echo "Docker Compose Kill [service]"
    container=$(docker_container_name $1)
    echo "Stoping container... $(docker container stop $container)"
    echo "Removing container... $(docker container rm $container)"    
}
dcu() {
    echo "Docker Compose Up [service] [-d]"
    dc up -d $1
    [ "$2" != "-d" ] && dcl $1
}
    '''
}

customize_shell_permanantly() {
   customize_shell > ~/.bash_profile_addons
   echo ". ~/.bash_profile_addons" >> ~/.bash_profile
}

customize_shell_temp() {
    tmp_file=~/tmp_shell.sh
    customize_shell >> $tmp_file
    . $tmp_file
    rm $tmp_file
}

echo '''Available functions: 
- install_softwares()
- customize_shell_temp()
- customize_shell_permanantly()
'''