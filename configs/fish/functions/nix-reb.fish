function nix-reb --wraps='sudo nixos-rebuild switch --flake .#mark --impure' --description 'alias nix-reb=sudo nixos-rebuild switch --flake .#mark --impure'
    sudo nixos-rebuild switch --flake .#mark --impure $argv
end
