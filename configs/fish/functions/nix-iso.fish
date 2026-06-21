function nix-iso --wraps='nix build .#nixosConfigurations.live.config.system.build.isoImage' --wraps='nix build .#nixosConfigurations.live.config.system.build.isoImage --impure' --description 'alias nix-iso=nix build .#nixosConfigurations.live.config.system.build.isoImage --impure'
    nix build .#nixosConfigurations.live.config.system.build.isoImage --impure $argv
end
