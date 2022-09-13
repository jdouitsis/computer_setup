echo "Backing up ssh..."
cd ssh
    cat ~/.ssh/config > config
    cat ~/.ssh/id_rsa > id_rsa
    cat ~/.ssh/id_rsa.pub > id_rsa.pub
cd -

echo "Backing up vscode..."
cd vscode
    code --list-extensions > extensions.list
    cp ~/Library/Application\ Support/Code/User/settings.json settings.json
cd -

echo "Backing up vim..."
cd vscode
    cp -r ~/.vim/ vim/
cd -