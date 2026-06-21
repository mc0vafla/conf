function ifelse --wraps='sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old; sudo nix-collect-garbage -d; nix store optimise; sudo journalctl --vacuum-time=1d; aa' --wraps='nh clean all; nix store optimise; sudo journalctl --vacuum-time=1d; aa' --description 'alias ifelse nh clean all; nix store optimise; sudo journalctl --vacuum-time=1d; aa'
    nh clean all; nix store optimise; sudo journalctl --vacuum-time=1d; aa $argv
end
