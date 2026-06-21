function cu --wraps='sudo nix-collect-garbage -d && nix-store --optimize' --description 'alias cu=sudo nix-collect-garbage -d && nix-store --optimize'
    sudo nix-collect-garbage -d && nix-store --optimize $argv
end
