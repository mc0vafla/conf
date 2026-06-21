function j --wraps='journalctl | grep' --description 'alias j=journalctl | grep'
    journalctl | grep $argv
end
