{
  pkgs,
  lib,
  host,
  config,
  ...
}:

let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../hosts/${host}/variables.nix) clock24h;
in
with lib;
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "custom/watson"
          "clock"
        ];
        modules-right = [
          "custom/notification"
          "bluetooth"
          "pulseaudio"
          "cpu"
          "memory"
          "idle_inhibitor"
          "battery"
          "group/tray-expander"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "clock" = {
          format = if clock24h == true then ''{:L%H:%M}'' else ''{:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
        };
        "hyprland/window" = {
          max-length = 22;
          separate-outputs = false;
          rewrite = {
            "" = " 🙈 No Windows? ";
          };
        };
        "bluetooth" = {
          format = "";
          format-disabled = "󰂲";
          format-connected = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "blueberry";
        };
        "memory" = {
          interval = 5;
          format = "";
          tooltip = true;
          on-click = "kitty --class=kitty-memory-control btop";
        };
        "cpu" = {
          interval = 5;
          format = "";
          tooltip = true;
          on-click = "kitty --class=kitty-cpu-control btop";
        };
        "disk" = {
          format = " {free}";
          tooltip = true;
        };
        "network" = {
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-ethernet = " {bandwidthDownOctets}";
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        "tray" = {
          spacing = 12;
        };
        "pulseaudio" = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "kitty --class=kitty-volume-control wiremix";
        };
        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          on-click = "sleep 0.1 && rofi-launcher";
        };
        "custom/hyprbindings" = {
          tooltip = false;
          format = "󱕴";
          on-click = "sleep 0.1 && list-hypr-bindings";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && task-waybar";
          escape = true;
        };
        "custom/watson" = {
          tooltip = false;
          format = " {}";
          exec = "watson-status";
          on-click = "watson stop";
          interval = 10;
          escape = true;
        };
        "custom/expand-icon" = {
          format = " ";
          tooltip = false;
        };
        "group/tray-expander" = {
          orientation = "inherit";
          drawer = {
            transition-duration = .6;
            children-class = "tray-group-item";
          };
          modules = [
            "custom/expand-icon"
            "tray"
            "custom/exit"
          ];
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          on-click = "";
          tooltip = false;
        };
      }
    ];
    style = concatStrings [
      ''
      @define-color foreground #cdd6f4;
      @define-color background #1a1b26;

        * {
          font-family: JetBrainsMono Nerd Font Mono, Font Awesome, sans-serif;
          background-color: @background;
          color: @foreground;
          border: none;
          border-radius: 0;
          min-height: 0;
          font-size: 12px;
        }
        .modules-left {
          margin-left: 8px;
        }

        .modules-right {
          margin-right: 8px;
        }
        #workspaces button {
          all: initial;
          padding: 0 6px;
          margin: 0 1.5px;
          min-width: 9px;
        }

        #workspaces button.empty {
          opacity: 0.5;
        }
        #workspaces button.active {
          font-weight: bolder;
        }

        #tray,
        #cpu,
        #battery,
        #network,
        #bluetooth,
        #pulseaudio,
        #clock,
        #custom-watson {
          min-width: 12px;
          margin: 0 7.5px;
        }

        #clock {
          background-color: @background;
          padding: 0 8px;
        }

        #custom-expand-icon {
          margin-right: 12px;
        }

        tooltip {
          padding: 2px;
        }
      ''
    ];
  };
}
