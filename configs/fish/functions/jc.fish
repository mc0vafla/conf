function jc --wraps='sudo journalctl --vacuum-time=1s' --description 'alias jc=sudo journalctl --vacuum-time=1s'
    sudo journalctl --vacuum-time=1s $argv
end
