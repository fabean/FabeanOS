{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    settings = {
      theme = "gruvbox-dark";
      show_startup_tips = false;
      keybinds = {
        unbind = [
          "Alt h"
          "Alt t"
          "Alt n"
          "Alt s"
          "Alt e"
        ];
      };
    };
  };
}
