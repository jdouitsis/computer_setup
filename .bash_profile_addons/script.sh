#################    General Aliases    ################# 
#########################################################
# This will create some basic but usefull aliases for 
# general use

alias r=". ~/.bash_profile"
alias gh="cd ~/Github"
alias c="clear"
alias l="ls -G -F"
alias la="l -a"


#######################    Git    ####################### 
#########################################################

# Here are all of the custom git commands
git config --global alias.uc "reset HEAD~"
git config --global alias.c "commit"
git config --global alias.cm "commit -m"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.aa "!git a; !git commit --amend --no-edit"
git config --global alias.aa "!git a && git amend"
git config --global alias.st "status -sb"
git config --global alias.l "log --oneline"
git config --global alias.se "!git rev-list --all | xargs git grep -F"
git config --global alias.ch "checkout"
git config --global alias.a "add . -A"
git config --global alias.rl "reflog"

# Shows all of the current aliases
alias ga="git config --get-regexp alias"
# prints the current branch
alias gb="git rev-parse --abbrev-ref HEAD"

# Adds the pre-rebase script to the given repo
gpr() {
    # This function adds a pre-rebase hook to 
    # the current repo
    if test -d ".git"; 
    then
        cat ~/.bash_profile_addons/git/hooks/pre-rebase > .git/hooks/pre-rebase
    else
        echo "No .git file found..."
    fi
}

####################### Terminal ########################
#########################################################

# https://medium.com/@adamtowers/how-to-customize-your-terminal-and-bash-profile-from-scratch-9ab079256380
export PS1="\[\033[01;32m\]\u\[\033[01;34m\]\w\[\033[00m\]\n\$ "

# Removes the warning regarding the zsh shell
export BASH_SILENCE_DEPRECATION_WARNING=1


######################## Docker #########################
#########################################################

# Setups shortcuts for docker
alias d="docker"
alias dc="docker-compose"

# Stop/rm containers/images/volumes
dsc() { docker container stop $(d container ls -a -q); }
drmc() { dsc; docker container rm $(d container ls -a -q) ; }
drmv() { docker volume rm $(d volume ls -q) ; }
drmi() { docker image rm -f $(d image ls -q) ; }
alias drma="dsc; drmc; drmv; drmi"

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
