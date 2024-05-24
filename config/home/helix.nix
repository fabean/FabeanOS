{ config, lib, pkgs, inputs, ... }:

let
  inherit (import ../../options.nix)
    flakeDir flakePrev hostname flakeBackup theShell;
in {
  # Configure Helix
  programs.helix = {
    enable = true;
    extraPackages = [
      pkgs.nodePackages_latest.intelephense
      pkgs.nodePackages.vscode-css-languageserver-bin
      pkgs.nodePackages_latest.typescript-language-server
    ];
    languages = {
      language-server.typescript-language-server = with pkgs.nodePackages; {
        command = "${typescript-language-server}/bin/typescript-language-server";
        args = [ "--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib" ];
      };
      language = [
        {
          name = "php";
          file-types = [
            "php"
            "inc"
            "php4"
            "php5"
            "phtml"
            "ctp"
            "module"
            "theme"
          ];
          debugger = {
            name = "vscode-php-debug";
            transport = "stdio";
            command = "node";
            args = [ "/home/josh/.vscode/extensions/xdebug.php-debug-1.34.0/out/phpDebug.js" ];
            templates = [{
              name = "Listen for XDebug";
              request = "launch";
              completion = ["ignored"];
              args = {};
            }];
          };
        }
      ];
    };

    settings = {
      keys.normal = {
        space.space = "file_picker";
      };
      editor.file-picker.hidden = false;
    };

  };
}
