function vlc --wraps='nix run nixpkgs#vlc' --description 'alias vlc=nix run nixpkgs#vlc'
    nix run nixpkgs#vlc $argv
end
