function serv --wraps='m /etc/nixos/services.nix' --description 'alias serv=m /etc/nixos/services.nix'
    m /etc/nixos/home/services.nix $argv
end
