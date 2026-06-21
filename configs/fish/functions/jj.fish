function jj --wraps='journalctl -r' --description 'alias jj=journalctl -r'
    journalctl -r $argv
end
