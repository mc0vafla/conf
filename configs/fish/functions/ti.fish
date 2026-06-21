function ti --wraps='tty-clock -c -C 4' --wraps='e nixpkgs#tty-clock -- -c -C 4' --description 'alias ti=e nixpkgs#tty-clock -- -c -C 4'
    e nixpkgs#tty-clock -- -c -C 4 $argv
end
