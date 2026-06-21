function nd --wraps='cd /etc/nixos/; nix develop; cd ~/' --wraps='cd /etc/nixos/; nix develop -- cd ~/ && fish; cd ~/' --wraps='cd /etc/nixos/; nix develop --run cd ~/ && fish; cd ~/' --description 'alias nd=cd /etc/nixos/; nix develop; cd ~/'
    cd /etc/nixos/; nix develop; cd ~/ $argv
end
