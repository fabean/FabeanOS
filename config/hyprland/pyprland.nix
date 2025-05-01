{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "wezterm --class wezterm-dropterm"
    class = "wezterm-dropterm"
    size = "75% 60%"
    max_size = "1920px 100%"

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
