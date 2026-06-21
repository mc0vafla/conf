function u --wraps='cd /etc/nixos/; sudo nix flake update; cd ~/ && aa' --description 'alias u cd /etc/nixos/; sudo nix flake update; cd ~/ && aa'
    cd /etc/nixos/; sudo nix flake update; cd ~/ && aa $argv
end
