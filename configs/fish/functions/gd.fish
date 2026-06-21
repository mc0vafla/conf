function gd --wraps='sudo git diff' --wraps='git diff' --description 'alias gd=git diff'
    git diff $argv
end
