# MacBook Initialization Script

## About

The purpose of this script is to take a blank MacBook pro from it's store bought state and install all of the required programs.

## Setting up the laptop

A user will take this script and run it once and then it will setup the computer perfectly for all of the tasks. The tasks that will be executed are as follows

### Git

Git information will be required and stored globally such as

- `user.name`
- `user.email`

### Brew

`brew` will be installed to allow all other applications to be installed

### Applications

The following GUI's will be installed

- Visual Studio Code
- Google Chrome
- Turbo Boost Switcher
- Docker
- WhatsApp
- DBeaver Community
- Rectangle
- TeamViewer
- AWS VPN Client

### Terminal Stuff

The following terminal softwares will be installed

- Node v16
- pyEnv
- Watch
- Alembic
- Postgresql
- Python 3.9.2
- Xcode Select

### Update screenshot location

The new screenshot location will be in `~/Pictures/Screenshots`

### SSH config

Takes everything in [`ssh`](ssh) and copies it to the `~/.ssh` directory.

It is currently left empty so that you can put your own `id_rsa`, `id_rsa.pub`, `config`, etc in to be added

### Customize shell

The [`.bash_profile_addons/script.sh`](.bash_profile_addons/script.sh) is added to the `~/.bash_profile` and runs every time the terminal opens. This script customizes the look of the terminal prompt as well as adds the ability to add add `git hooks` to `git repos` and adds a variety of other commands that can be used.

## Execution

In order to run the script, all you need to do is enter the following in the root of this repository:

```sh
. init.sh
```

## Backup

If you run the `backup.sh` script by executing the below code:

```sh
. backup.sh
```

Then it will copy all of the files from `~/.ssh` into the `./ssh` file as well as the vscode user settings and extensions.
