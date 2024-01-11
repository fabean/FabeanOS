{ pkgs }:

pkgs.writeShellScriptBin "watson-status" ''
  project="$(${pkgs.watson}/bin/watson status -p)"
  this_time="$(${pkgs.watson}/bin/watson status -e)"

  if [ "$project" == "No project started." ]; then
    echo ""
  else
    echo "$project: $this_time"
  fi
''


