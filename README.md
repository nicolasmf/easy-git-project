# Easy git project

This is my first Oh My Zsh plugin.

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
| gp         | git push origin $(git_current_branch)                                            |
| readme     | echo \# $PWD:t > README.md                                                       |
| webproject | mkdir img styles scripts && touch scripts/script.js index.html styles/styles.css |

## Functions 

|    Function   |                       Description                         |
| :------------ | :-------------------------------------------------------- | 
| create.repo   | Create a repository with specified name.                  |
| g.cpush       | Commit and push to current branch.                        |
| g.pushto      | Push to specified branch.                                 |
| make.repo     | Create a repository from existing project.                |