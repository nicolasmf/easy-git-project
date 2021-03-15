autoload -Uz is-at-least

error="$fg_bold[red][!]$reset_color"
git_current_branch=`git rev-parse --abbrev-ref HEAD`

create.repo() { # create.repo <repo_name>

    if (( # == 0 || # > 1)); then
        echo "$error Invalid repository name"
        return 0
    fi

    local repo=$1

    mkdir "$repo"
    cd "$repo"
    readme
    git init
    hub create -o
    git add .
    git commit -m "Initial commit"
    git push origin master
}

make.repo() { # make.repo
    
    git init
    hub create
    git add .
    git commit -m "Initial commit"
    git push origin master
}

g.cpush(){ # g.cpush <commit_message>
    if (( # == 0 || # > 1)); then
        echo "$error Invalid commit message."
        return 0
    fi

    git add .
    git commit -m "$1"
    gp

}

g.pushto(){ # g.pushto <branch_name>
    if (( # == 0 || # > 1)); then
        echo "$error Invalid branch name."
        return 0
    fi

    local branch_name=$1

    local command=`git rev-parse --verify $branch_name` 2>/dev/null

    if  [[ ! -z $command ]]; then
        git push origin "$branch_name"
        return 0
    fi

    echo "$error Branch doesn't exist."
}

g.goto(){ # g.goto <branch_name>
    if (( # == 0 || # > 1)); then
        echo "$error Invalid branch name."
        return 0
    fi

    local branch_name=$1
    local command=`git rev-parse --verify $branch_name` 2>/dev/null

    if  [[ -z $command ]]; then
        echo "$error Branch doesn't exist."
        return 0
    fi

    git checkout $branch_name
    return 0
}


alias g='git'
alias g.fpush='git push origin $(git_current_branch) --force'
alias g.apush='git push --all origin'
alias g.apull='git pull --all'
alias gaa='git add .'
alias gb='git branch'
alias gbc='git checkout'
alias gc='git commit -m '
alias gi='git init'
alias gignore='touch .gitignore'
alias gp='git push -u origin $(git_current_branch)'
alias readme='echo \# $PWD:t > README.md'
alias webproject='mkdir img styles scripts && touch scripts/script.js index.html styles/styles.css'