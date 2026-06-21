function nix-test --wraps='nix-instantiate --eval' --description 'alias nix-test=nix-instantiate --eval'
    nix-instantiate --eval $argv
end
