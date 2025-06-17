{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    settings = {
      theme = "gruvbox-dark";
    };
  };
}
