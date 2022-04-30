# Computer Initialization Script

## About

The purpose of this script is to take a blank MacBook pro from it's store bought state and install all of the required programs.

## User Stories

### Setting up the laptop

A user will take this script and run it once and then it will setup the computer perfectly for all of the tasks. This includes setting up the `brew` package manager and then using `brew` to install all of the used GUI applications (VSCode, Chrome, WhatsApp, etc) and terminal softwares (`xcode`, `python`, `alembic`, etc).

### Setting up additional terminal functionality

Along with Installing all of the proper softwares, this script will also configure the terminal itself and add additional functionality

- terminal prompt
- `git`
  - Add aliases
  - Setup credentials
    - name
    - email
  - Hooks
    - pre-rebase

It will also setup specific functions tied to their bash profile that will execute certain tasks for them. Such tasks include adding a `pre-rebase` script to git repos

## Execution
