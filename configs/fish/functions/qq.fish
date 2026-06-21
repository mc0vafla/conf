function qq --wraps='nh os diff' --wraps='nvd diff /run/current-system /nix/var/nix/profiles/system-*-link' --description 'alias qq=nvd diff /run/current-system /nix/var/nix/profiles/system-*-link'
    nvd diff /run/current-system /nix/var/nix/profiles/system-*-link $argv
end
