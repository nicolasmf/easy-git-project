# Easy git project

This is my first Oh My Zsh plugin. It's made to use git in a faster and more understandlable way.

## Requirements


### Oh My Zsh


#### Windows 

[How to Install Oh My Zsh! on Windows 10 Home Edition](https://dev.to/vsalbuq/how-to-install-oh-my-zsh-on-windows-10-home-edition-49g2)


#### Mac OS / Linux 

Install Oh My Zsh via curl

`$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Install Oh My Zsh via wget

`$ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"`


### Git 

Install git for [Windows](https://git-scm.com/download/win)

Install git for [Mac OS X](https://git-scm.com/download/mac)

Install git for [Linux](https://git-scm.com/download/linux)


### Hub 

[Github](https://github.com/github/hub)

|   Platform    |                      Manager                  |        Command        |
| :------------ | :-------------------------------------------- | :-------------------- |
| macOS, Linux  | [Homebrew](https://docs.brew.sh/Installation) | `brew install hub`    |
| macOS, Linux  | [Nix](https://nixos.org/)                     | `nix-env -i hub`      |
| Windows       | [Scoop](http://scoop.sh/)                     | `scoop install hub`   |
| Windows       | [Chocolatey](https://chocolatey.org/)         | `choco install hub`   |

#### Bad credentials error

Create a new [PAT](https://github.com/settings/tokens) (Personal access token) and use this token instead of your github password


## Installation

See [INSTALL.md](INSTALL.md)

## Aliases

|    Alias   |                                  Command                                         |
| :--------- | :------------------------------------------------------------------------------- | 
| g          | git                                                                              |
| g.fpush    | git push origin $(git_current_branch) --force                                    |
| g.apush    | git push --all origin                                                            |
| g.apull    | git pull --all                                                                   |
| gaa        | git add .                                                                        |
| gb         | git branch                                                                       |
| gbc        | git checkout                                                                     |
| gc         | git commit -m                                                                    |
| gi         | git init                                                                         |
| gignore    | touch .gitignore                                                                 |
| readme     | echo \# $PWD:t > README.md                                                       |
| webproject | mkdir img styles scripts && touch scripts/script.js index.html styles/styles.css |

## Functions 

|    Function   |                       Description                         | Usage                                 |
| :------------ | :-------------------------------------------------------- | :------------------------------------ |
| create.repo   | Create a repository with specified name.                  | create.repo <repo_name> (-p)          |
| g.cpush       | Commit and push to current branch.                        | g.cpush <commit_message>              |
| g.pushto      | Push to specified branch.                                 | g.pushto <branch_name>                |
| make.repo     | Create a repository from existing project.                | make.repo (-p)                        |
| g.goto        | Checkout to specified branch.                             | g.goto <branch_name>                  |
| g.brename     | Rename specified branch.                                  | g.brename <old_branch> <new_branch>   |
| g.pushto      | Push to actual branch.                                    | g.pushto                              |
| g.help        | Print commands list with description                      | g.help                                |
| repo.delete   | Delete actual repository                                  | repo.delete OR repo.delete -y         |