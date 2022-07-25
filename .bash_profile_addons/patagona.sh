
pfbs() {
    . venv/bin/activate;
    export GOOGLE_APPLICATION_CREDENTIALS="./firebase_service_account_key.json"; 
    uvicorn main:app --reload --port 8001;
}



# ZEN
alias ssh-gw="ssh mindrocket@gateway.legendaryneuro.pro"
alias c-ssh-gw="ssh-keygen -f '$HOME/.ssh/known_hosts' -R 'gateway.legendaryneuro.pro'"

alias dl='aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 375279591029.dkr.ecr.us-east-2.amazonaws.com'

dl-mr() {
    cd ~/docker-compose-files
    export $(cat .env | xargs)
    aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_ECR
}

alias get-ip="ifconfig | grep '(192.168\|10.[0-9]*.[0-9]*.[0-9]*. \|172.16\|100.64)\.'"

# Set compose environments
alias dcd='export COMPOSE_FILE= ; r'
alias dct='export COMPOSE_FILE=test.yml; r'
alias dctl='export COMPOSE_FILE=docker-compose.yml:test.local.yml; r'
alias dcp='export COMPOSE_FILE=docker-compose.yml:docker-compose.prod.yml; r'

PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;34m\]\w\[\033[00m\]\n\$ "
if [ ! -z $COMPOSE_FILE ]; 
then
    if [[ "$COMPOSE_FILE" == *".prod."* ]];
    then
        PS1="(P) $PS1"
    elif [[ "$COMPOSE_FILE" == *"test.local"* ]];
    then
        PS1="(TL) $PS1"
    else
        PS1="(T) $PS1"
    fi  
fi