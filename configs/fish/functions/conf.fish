function conf --wraps='cd /etc/nixos/modules/configurations' --description 'alias conf=cd /etc/nixos/modules/configurations'
    nvim /etc/nixos/configuration.nix $argv
end
