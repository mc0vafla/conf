function optimize --wraps='nix store gc && sudo nix store optimise' --description 'alias optimize=nix store gc && sudo nix store optimise'
    nix store gc && sudo nix store optimise $argv
end
