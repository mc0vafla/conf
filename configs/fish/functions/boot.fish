function boot --wraps='micro /etc/nixos/modules/system/boot.nix' --wraps='micro /etc/nixos/boot.nix' --description 'alias boot micro /etc/nixos/boot.nix'
    micro /etc/nixos/nix/boot.nix $argv
end
