function gl --wraps='git config user.email root@mark && git config user.name root' --wraps='git remote add origin git@github.com:mc0vafla/mark.git' --wraps='git remote add origin https://github.com/mc0vafla/mark.git' --description 'alias gl=git remote add origin https://github.com/mc0vafla/mark.git'
    git remote add origin https://github.com/mc0vafla/conf.git $argv
end
