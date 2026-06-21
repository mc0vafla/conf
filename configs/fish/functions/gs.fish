function gs --wraps='git add . && git commit -m 1' --description 'alias gs=git add . && git commit -m 1'
    git add . && git commit -m 1 $argv
end
