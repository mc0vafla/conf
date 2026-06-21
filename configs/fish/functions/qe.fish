function qe --wraps='ncdu /nix/store' --description 'alias qe=ncdu /nix/store'
    ncdu /nix/store $argv
end
