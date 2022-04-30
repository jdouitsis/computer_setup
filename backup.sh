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
