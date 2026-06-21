function nix-gens --wraps='nix-env --list-generations --profile /nix/var/nix/profiles/system' --wraps='sudo nix-env --list-generations --profile /nix/var/nix/profiles/system' --wraps='nh os info' --description 'alias nix-gens=nh os info'
    nh os info $argv
end
