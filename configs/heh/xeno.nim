import std/[os, osproc, strutils]

proc runTemporary(pkg: string) =
  let result = execCmdEx("nix run nixpkgs#" & pkg)
  if result.exitCode != 0:
    let output = result.output
    if "Did you mean" in output:
      echo "Oh! I couldn't find '" & pkg & "', but look what Nix suggested: "
      let lines = output.splitLines()
      for line in lines:
        if "Did you mean" in line:
          echo line.strip()
    else:
      echo "I couldn't run it and didn't find any suggestions... I'm so sorry!"

proc main() =
  if paramCount() > 0:
    runTemporary(paramStr(1))

main()
