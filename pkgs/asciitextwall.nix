{
  lib,
  python3Packages,
  fetchFromGitHub,
  nix-update-script,
}:
python3Packages.buildPythonApplication (finalAttrs: {
  pname = "asciitextwall";
  version = "0-unstable-2026-06-14";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "MrE8065";
    repo = "asciitextwall";
    rev = "2f0b2abbb261f2a8004873a1327fa431e23dee26";
    hash = "sha256-tLBG3n5iv6HNVa+Vnr5W/69dYPFpwR4KvjzsBvmVtRU=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  dependencies = with python3Packages; [
    pillow
    pyfiglet
  ];

  postInstall = ''
    mkdir -p $out/bin
    if [ ! -f "$out/bin/asciitextwall" ]; then
      if [ -f "asciitextwall.py" ]; then
        echo "#!/usr/bin/env python3" > $out/bin/asciitextwall
        cat asciitextwall.py >> $out/bin/asciitextwall
      elif [ -f "main.py" ]; then
        echo "#!/usr/bin/env python3" > $out/bin/asciitextwall
        cat main.py >> $out/bin/asciitextwall
      fi
      chmod +x $out/bin/asciitextwall
    fi
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/asciitextwall --help > /dev/null
    runHook postInstallCheck
  '';

  passthru.updateScript = nix-update-script {};

  meta = {
    description = "Simple tool to generate ascii text wallpapers";
    homepage = "https://github.com/MrE8065/asciitextwall";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "asciitextwall";
  };
})
