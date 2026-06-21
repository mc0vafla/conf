{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    curl
    neovim
    yazi
    lsd
    fd
    fzf
    #
  ];
}
