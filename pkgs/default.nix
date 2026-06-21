final: prev: let
  dirContents = builtins.readDir ./.;
  nixFiles = builtins.filter (
    name:
      dirContents.${name}
      == "regular"
      && name != "default.nix"
      && builtins.match ".*\\.nix" name != null
  ) (builtins.attrNames dirContents);
  importedPkgs = builtins.listToAttrs (builtins.map (name: let
      pname = builtins.head (builtins.split "\\.nix" name);
      pkg = final.callPackage (./. + "/${name}") {};
    in {
      name = pname;
      value = pkg.overrideAttrs (oldAttrs: {
        makeFlags = (oldAttrs.makeFlags or []) ++ ["PREFIX=$(out)"];
      });
    })
    nixFiles);
in
  importedPkgs
