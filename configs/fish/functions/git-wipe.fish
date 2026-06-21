function git-wipe --wraps='rm -rf .git; and git init' --description 'alias git-wipe=rm -rf .git; and git init'
    rm -rf .git; and git init $argv
end
