function filelight --wraps='nix run nixpkgs#kdePackages.filelight' --description 'alias filelight=nix run nixpkgs#kdePackages.filelight'
    nix run nixpkgs#kdePackages.filelight $argv
end
