function mod --wraps='cd /etc/nixos/modules/' --description 'alias mod=cd /etc/nixos/modules/'
    nvim /etc/nixos/modules.nix $argv
end
