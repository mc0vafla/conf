{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ncurses,
  nix-update-script,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "pride-matrix";
  version = "0-unstable-2026-06-19";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "VixurHD";
    repo = "pride-matrix";
    rev = "4a8ce5c4f4e7e38a14c1371823c831bd468dc763";
    hash = "sha256-paolPfwAdUV/rrsYaQfK6BMOC8WVuSLLXtK1EWKtoQc=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    ncurses
  ];

  postInstall = ''
    if [ -f "$out/bin/cmatrix" ]; then
      mv "$out/bin/cmatrix" "$out/bin/pride-matrix"
    fi
  '';

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Cmatrix but have pride flags mode";
    homepage = "https://github.com/VixurHD/pride-matrix";
    changelog = "https://github.com/VixurHD/pride-matrix/blob/${finalAttrs.src.rev}/ChangeLog";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "pride-matrix";
    platforms = lib.platforms.all;
  };
})
