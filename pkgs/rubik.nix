{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "rbrubik";
  version = "0.0.3";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "Re-nault16";
    repo = "RBrubik";
    tag = "v${finalAttrs.version}";
    hash = "sha256-RY+0FusGFg2S8K4g8i9Q8hY3W8AP47hh4JaBWipo02w=";
  };

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "A terminal-based animated 3D Rubik's Cube renderer";
    homepage = "https://github.com/Re-nault16/RBrubik";
    changelog = "https://github.com/Re-nault16/RBrubik/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "rbrubik";
    platforms = lib.platforms.all;
  };
})
