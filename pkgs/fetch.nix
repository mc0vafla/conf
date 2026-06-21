{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "fetch";
  version = "2.1.0";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "areofyl";
    repo = "fetch";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9ixx7XJcY4ktcN/lUfjvFljvHIEO2ktOebeGgL0ulHg=";
  };

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "An animated 3D fetch tool for your terminal. Takes your distro's ASCII logo, turns it into a spinning 3D object, and displays system info alongside it";
    homepage = "https://github.com/areofyl/fetch";
    changelog = "https://github.com/areofyl/fetch/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.isc;
    maintainers = with lib.maintainers; [];
    mainProgram = "fetch";
    platforms = lib.platforms.all;
  };
})
