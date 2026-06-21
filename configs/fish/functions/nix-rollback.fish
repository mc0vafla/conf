function nix-rollback --wraps='sudo nixos-rebuild switch --rollback' --description 'alias nix-rollback=sudo nixos-rebuild switch --rollback'
    sudo nixos-rebuild switch --rollback $argv
end
