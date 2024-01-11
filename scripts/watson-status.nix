{ pkgs }:

pkgs.writeShellScriptBin "watson-status" ''
  project="$(${pkgs.watson}/bin/watson status -p)"
  this_time="$(${pkgs.watson}/bin/watson status -e)"
  tag=$(${pkgs.watson}/bin/watson status -t | tr -d '[]')

  if [ "$project" == "No project started." ]; then
    echo ""
  else
    echo "$project +$tag: $this_time"
  fi
''


