function ll --wraps='ls -l' --wraps='lsd -l' --description 'alias ll=lsd -l'
    lsd -l $argv
end
