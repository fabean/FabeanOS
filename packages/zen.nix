{ appimageTools, fetchurl, makeWrapper, ... }:
let
  pname = "zen";
  version = "latest";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen-x86_64.AppImage";
    sha256 = "sha256-hZiJ8JLzLhtD1W8DAso3yBAJYhFE+nJEbQJa59AWjnU=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    # Install .desktop file
    install -m 444 -D ${appimageContents}/zen.desktop $out/share/applications/${pname}.desktop
    # Install icon
    install -m 444 -D ${appimageContents}/zen.png $out/share/icons/hicolor/128x128/apps/${pname}.png
    # Make sure bin directory exists
    mkdir -p $out/bin
    # Wait for the wrapped binary to exist and then create the symlink
    if [ -f "$out/bin/${pname}-${version}" ]; then
      ln -sf "${pname}-${version}" $out/bin/${pname}
    else
      echo "Error: Wrapped binary $out/bin/${pname}-${version} does not exist"
      exit 1
    fi
  '';

  meta = {
    platforms = [ "x86_64-linux" ];
  };
}