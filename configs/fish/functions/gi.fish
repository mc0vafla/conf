function gi --wraps='sudo git log' --wraps='git log' --description 'alias gi=git log'
    git log $argv
end
