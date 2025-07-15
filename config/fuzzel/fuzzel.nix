{ config, pkgs, ... }:

let
  stylix = config.stylix.base16Scheme;
  font = "JetBrainsMono Nerd Font:size=12";
in {
  home.file.".config/fuzzel/fuzzel.ini".text = ''
[main]
font=${font}
dpi-aware=yes

[colors]
background=${stylix.base00}ee
text=${stylix.base05}cc
match=${stylix.base08}ff
selection=${stylix.base02}ff
selection-text=${stylix.base06}ff
border=${stylix.base09}ff

[border]
width=2
radius=20
'';
}
