{lib, ...}: {
  imports = let
    getNixFiles = dir: let
      content = builtins.readDir dir;
      nixFiles =
        builtins.filter
        (name: content.${name} == "regular" && lib.hasSuffix ".nix" name && name != "default.nix")
        (builtins.attrNames content);
    in
      builtins.map (name: dir + "/${name}") nixFiles;
  in
    (getNixFiles ./nix) ++ (getNixFiles ./home);
}
