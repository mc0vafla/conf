function sus --wraps='m /etc/nixos/modules/system/basic.nix' --wraps='m /etc/nixos/basic.nix' --description 'alias sus=m /etc/nixos/basic.nix'
    m /etc/nixos/basic.nix $argv
end
