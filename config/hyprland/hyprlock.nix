{username, lib, ...}: {
  programs.hyprlock = {
    enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
          no_unlock_animation = false;
          ignore_empty_input = false;
        };
        background = lib.mkForce [
          {
            blur_passes = 3;
            blur_size = 8;
            path = "/home/josh/Pictures/Wallpapers/sunrise.jpg";
          }
        ];
        image = lib.mkForce [
          {
            path = "/home/${username}/.config/face.jpg";
            size = 150;
            border_size = 4;
            border_color = "rgb(0C96F9)";
            rounding = -1; # Negative means circle
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];
        input-field = lib.mkForce [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(CFE6F4)";
            inner_color = "rgb(657DC2)";
            outer_color = "rgb(0D0E15)";
            outline_thickness = 5;
            placeholder_text = "Password...";
            shadow_passes = 2;
            check_color = "rgb(0C96F9)";
            fail_color = "rgb(FF0000)";
            capslock_color = "rgb(F9A80C)";
            password_input = true;
            swap_input_on_fail = true;
          }
        ];
      };
  };
}
