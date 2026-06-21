function k --wraps=python3 --wraps='nix run python3' --description 'alias k=nix run python3'
    nix run python3 $argv
end
