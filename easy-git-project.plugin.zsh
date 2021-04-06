autoload -Uz is-at-least

error="$fg_bold[red][!]$reset_color"

alias g='git'
alias g.apush='git push --all origin'
alias g.apull='git pull --all'
alias gaa='git add .'
alias gb='git branch'
alias gbc='git checkout'
alias gc='git commit -m '
alias gi='git init'
alias gignore='touch .gitignore'
alias readme='echo \# $PWD:t > README.md'
alias webproject='mkdir img styles scripts && touch scripts/script.js index.html styles/styles.css'

create.repo() { # create.repo <repo_name>

    if (( # == 0 || # > 2)); then
        echo "$error Invalid repository name"
        return 0
    fi

    local repo=$1

    mkdir "$repo"
    cd "$repo"
    echo \# $PWD:t > README.md
    git init

    if [ "$2" = "-p" ]; then
        hub create -p
    else
        hub create
    fi

    git add .
    git commit -m "Initial commit"
    git push -u origin master
}

make.repo() { # make.repo

    git init
    
    if [ "$2" = "-p" ]; then
        hub create -p
    else
        hub create
    fi

    git add .
    git commit -m "Initial commit"
    git push -u origin master
}

create.bot() {
    npm init -y
    npm install discord.js
    npm install eslint
    npm install dotenv
    cat >> .eslintrc.json << EOF
{
  "extends": "eslint:recommended",
  "env": {
    "node": true,
    "es6": true
  },
  "parserOptions": {
    "ecmaVersion": 2019
  },
  "rules": {
    "brace-style": ["error", "stroustrup", { "allowSingleLine": true }],
    "comma-dangle": ["error", "always-multiline"],
    "comma-spacing": "error",
    "comma-style": "error",
    "curly": ["error", "multi-line", "consistent"],
    "dot-location": ["error", "property"],
    "handle-callback-err": "off",
    "indent": ["error", "tab"],
    "max-nested-callbacks": ["error", { "max": 4 }],
    "max-statements-per-line": ["error", { "max": 2 }],
    "no-console": "off",
    "no-empty-function": "error",
    "no-floating-decimal": "error",
    "no-lonely-if": "error",
    "no-multi-spaces": "error",
    "no-multiple-empty-lines": [
      "error",
      { "max": 2, "maxEOF": 1, "maxBOF": 0 }
    ],
    "no-shadow": ["error", { "allow": ["err", "resolve", "reject"] }],
    "no-trailing-spaces": ["error"],
    "no-var": "error",
    "object-curly-spacing": ["error", "always"],
    "prefer-const": "error",
    "quotes": ["error", "single"],
    "semi": ["error", "always"],
    "space-before-blocks": "error",
    "space-before-function-paren": [
      "error",
      {
        "anonymous": "never",
        "named": "never",
        "asyncArrow": "always"
      }
    ],
    "space-in-parens": "error",
    "space-infix-ops": "error",
    "space-unary-ops": "error",
    "spaced-comment": "error",
    "yoda": "error",
    "no-unused-vars": "off"
  }
}
EOF
    cat >>  index.js << EOF 
    const Discord = require('discord.js');
    const fs = require('fs');

    require('dotenv').config();
    const prefix = process.env.PREFIX;
    const owner = process.env.OWNER;
    const token = process.env.TOKEN;

    const client = new Discord.Client();
    client.commands = new Discord.Collection();

    const commandFiles = fs.readdirSync('./commands').filter(file => file.endsWith('.js'));

    for (const file of commandFiles) {
        const command = require(`./commands/${file}`);
        client.commands.set(command.name, command);
    }

    client.on('ready', () => {
        console.log('Ready!');
    });

    client.on('message', message => {
        if (!message.content.startsWith(prefix) || message.author.bot) return;

        const args = message.content.slice(prefix.length).trim().split(/ +/);
        const commandName = args.shift().toLowerCase();

        if (!client.commands.has(commandName)) return;

        const command = client.commands.get(commandName);

        try {
            command.execute(client, message, args);
        }
        catch (error) {
            message.reply('Error: ' + error);
        }
    })

    client.login(token);
EOF

    cat >> .env << EOF
TOKEN=
OWNER=
PREFIX=
EOF

}

g.cpush(){ # g.cpush <commit_message>
    if (( # == 0 || # > 1)); then
        echo "$error Invalid commit message."
        return 0
    fi

    git add .
    git commit -m "$1"
    g.push

}

g.pushto(){ # g.pushto <branch_name>
    if (( # == 0 || # > 1)); then
        echo "$error Invalid branch name."
        return 0
    fi

    local branch_name=$1

    local command=`git rev-parse --verify $branch_name` 2>/dev/null

    if  [[ ! -z $command ]]; then
        git push -u origin "$branch_name"
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

g.brename(){ # g.brename <old_branch> <new_branch>

    if (( # == 0 || # == 1 || # > 2 )); then
        echo "$error Invalid branches names."
        return 0
    fi

    old_branch=$1
    new_branch=$2

    local command=`git rev-parse --verify $old_branch` 2>/dev/null
    if  [[ -z $command ]]; then
        echo "$error Branch '$old_branch' doesn't exist."
        return 0
    fi

    local git_current_branch=`git rev-parse --abbrev-ref HEAD`

    if [ "$git_current_branch" = "$old_branch" ]; then
        
        git branch -m $new_branch
        git push origin :$old_branch $new_branch
        git push origin -u $new_branch
        return 0
    fi

    git checkout $old_branch
    git branch -m $new_branch
    git push origin :$old_branch $new_branch
    git push origin -u $new_branch
    return 0

}

g.fpush(){ 
    local git_current_branch=`git rev-parse --abbrev-ref HEAD`
    git push origin $git_current_branch --force
}

g.push(){ 
    local git_current_branch=`git rev-parse --abbrev-ref HEAD`
    git push -u origin $git_current_branch
}

repo.delete(){

    if [[ ! -d "$PATH/.git" ]]; then
        echo "$error Not in a repository."
        return 0
    fi

    if [ "$1" = "-y" ]; then
        hub delete -y $PWD:t
    else
        hub delete $PWD:t
    fi

}

.tsc(){

    file=$1
    extension="${1##*.}"
    filename="${1%.*}"

    if (( # == 0 || # > 1 )); then
        echo "$error Invalid file name."
        return 0
    fi

    if [ ! "$extension" = "ts" ]; then
       echo "$error Invalid file extension."
       return 0
    fi
    
    echo "Building..." && tsc "$file" && echo "[Done]\n" && node "$filename".js && rm "$filename".js
}

g.help() {
    echo "Commands List :" 
    echo "create.repo : Create a repository with specified name."
    echo "g.cpush : Commit and push to current branch."
    echo "g.pushto : Push to specified branch."       
    echo "make.repo : Create a repository from existing project."
    echo "g.goto : Checkout to specified branch." 
    echo "g.brename : Rename specified branch." 
    echo "g.pushto : Push to actual branch."
    echo "repo.delete : Delete actual repository."
    echo ".tsc : build and run typescript"
}
