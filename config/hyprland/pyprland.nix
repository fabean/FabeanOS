{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "50% 50%"
    max_size = "1000px 1000px"

    [scratchpads.volume]
    animation = "fromTop"
    command = "pavucontrol"
    class = "pavucontrol"
    lazy = true
    size = "40% 90%"

    [scratchpads.bluetooth]
    animation = "fromTop"
    command = "blueman-manager"
    class = "blueman-manager-wrapped"
    lazy = true
    size = "40% 90%"

    [scratchpads.thunar]
    animation = "fromBottom"
    command = "thunar"
    class = "thunar"
    size = "75% 60%"
  '';
}
