{ pkgs, config, lib, ... }:

let
  palette = config.colorScheme.palette;
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../options.nix) slickbar bar-number simplebar clock24h;
in with lib; {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";

      modules-center = [ "hyprland/workspaces" ];
      modules-left = [
        "custom/startmenu"
        "hyprland/window"
        "pulseaudio"
        "cpu"
        "memory"
        "custom/watson"
      ];
      modules-right = [
        "custom/hyprbindings"
        "custom/exit"
        "idle_inhibitor"
        "custom/themeselector"
        "custom/notification"
        "battery"
        "clock"
        "tray"
      ];

      "hyprland/workspaces" = {
        format = if bar-number == true then "{name}" else "{icon}";
        format-icons = {
          default = " ";
          active = " ";
          urgent = " ";
        };
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
        format = if clock24h == true then "{: %H:%M}" else "{: %I:%M %p}";
        tooltip = true;
        tooltip-format =
          "<big>{:%A, %d.%B %Y }</big><tt><small>{calendar}</small></tt>";
      };
      "hyprland/window" = {
        max-length = 25;
        separate-outputs = false;
      };
      "memory" = {
        interval = 5;
        format = " {}%";
        tooltip = true;
      };
      "cpu" = {
        interval = 5;
        format = " {usage:2}%";
        tooltip = true;
      };
      "disk" = {
        format = " {free}";
        tooltip = true;
      };
      "network" = {
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "tray" = { spacing = 12; };
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
          default = [ "" "" "" ];
        };
        on-click = "sleep 0.1 && pavucontrol";
      };
      "custom/themeselector" = {
        tooltip = false;
        format = "";
        on-click = "sleep 0.1 && theme-selector";
      };
      "custom/exit" = {
        tooltip = false;
        format = "";
        on-click = "sleep 0.1 && wlogout";
      };
      "custom/startmenu" = {
        tooltip = false;
        format = " ";
        # exec = "rofi -show drun";
        on-click = "sleep 0.1 && rofi-launcher";
      };
      "custom/hyprbindings" = {
        tooltip = false;
        format = " Bindings";
        on-click = "sleep 0.1 && list-hypr-bindings";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
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
          inhibited-notification =
            "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification =
            "<span foreground='red'><sup></sup></span>";
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
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        on-click = "";
        tooltip = false;
      };
    }];
    style = concatStrings [''
            * {
      	font-size: 16px;
      	font-family: JetBrainsMono Nerd Font, Font Awesome, sans-serif;
          	font-weight: bold;
            }
            window#waybar {
      	${
         if slickbar == true || simplebar == true then
           "  background-color: rgba(26,27,38,0);\n  border-bottom: 1px solid rgba(26,27,38,0);\n  border-radius: 0px;\n  color: #${palette.base0F};\n"
         else
           "  background-color: #${palette.base00};\n  border-bottom: 1px solid #${palette.base00};\n  border-radius: 0px;\n  color: #${palette.base0F};\n"
       }
            }
            #workspaces {
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  margin: 5px;\n  padding: 0px 1px;\n  border-radius: 15px;\n  border: 0px;\n  font-style: normal;\n  color: #${palette.base00};\n"
         else if simplebar == true then ''
           	  color: #${palette.base00};
                     background: transparent;
           	  margin: 4px;
           	  border-radius: 0px;
           	  border: 0px;
           	  font-style: normal;
           	'' else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 0px 1px;\n  border-radius: 10px;\n  border: 0px;\n  font-style: normal;\n  color: #${palette.base00};\n"
       }
            }
            #workspaces button {
      	${
         if slickbar == true then
           "  padding: 0px 5px;\n  margin: 4px 3px;\n  border-radius: 15px;\n  border: 0px;\n  color: #${palette.base00};\n  background: linear-gradient(45deg, #${palette.base0C}, #${palette.base0D}, #${palette.base0E});\n  opacity: 0.5;\n  transition: ${betterTransition};\n"
         else if simplebar == true then ''
           	  color: #${palette.base03};
                     background: #${palette.base00};
           	  margin: 4px 3px;
           	  opacity: 1;
           	  border: 0px;
           	  border-radius: 15px;
           	  transition: ${betterTransition};
           	'' else ''
             	  padding: 0px 5px;
             	  margin: 4px 3px;
             	  border-radius: 10px;
             	  border: 0px;
             	  color: #${palette.base00};
                       background: linear-gradient(45deg, #${palette.base0E}, #${palette.base0F}, #${palette.base0D}, #${palette.base09});
                       background-size: 300% 300%;
                       animation: gradient_horizontal 15s ease infinite;
             	  opacity: 0.5;
                       transition: ${betterTransition};
             	''
       }
            }
            #workspaces button.active {
      	${
         if slickbar == true then
           "  padding: 0px 5px;\n  margin: 4px 3px;\n  border-radius: 15px;\n  border: 0px;\n  color: #${palette.base00};\n  background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});\n  opacity: 1.0;\n  min-width: 40px;\n  transition: ${betterTransition};\n"
         else if simplebar == true then ''
           	  color: #${palette.base00};
                     background: linear-gradient(118deg, #${palette.base0D} 5%, #${palette.base0F} 5%, #${palette.base0F} 20%, #${palette.base0D} 20%, #${palette.base0D} 40%, #${palette.base0F} 40%, #${palette.base0F} 60%, #${palette.base0D} 60%, #${palette.base0D} 80%, #${palette.base0F} 80%, #${palette.base0F} 95%, #${palette.base0D} 95%);
                     background-size: 300% 300%;
                     animation: swiping 15s linear infinite;
           	  border-radius: 15px;
           	  margin: 4px 3px;
           	  opacity: 1.0;
           	  border: 0px;
           	  min-width: 45px;
           	  transition: ${betterTransition};
           	'' else ''
             	  padding: 0px 5px;
             	  margin: 4px 3px;
             	  border-radius: 10px;
             	  border: 0px;
             	  color: #${palette.base00};
                       background: linear-gradient(45deg, #${palette.base0E}, #${palette.base0F}, #${palette.base0D}, #${palette.base09});
                       background-size: 300% 300%;
                       animation: gradient_horizontal 15s ease infinite;
                       transition: ${betterTransition};
             	  opacity: 1.0;
             	  min-width: 40px;
             	''
       }
            }
            #workspaces button:hover {
      	${
         if slickbar == true then
           "  border-radius: 15px;\n  color: #${palette.base00};\n  background: linear-gradient(45deg, #${palette.base0D}, #${palette.base0E});\n  opacity: 0.8;\n  transition: ${betterTransition};\n"
         else if simplebar == true then
           "  color: #${palette.base05};\n  border: 0px;\n  border-radius: 15px;\n  transition: ${betterTransition};\n"
         else ''
           	  border-radius: 10px;
           	  color: #${palette.base00};
                     background: linear-gradient(45deg, #${palette.base0E}, #${palette.base0F}, #${palette.base0D}, #${palette.base09});
                     background-size: 300% 300%;
                     animation: gradient_horizontal 15s ease infinite;
           	  opacity: 0.8;
                     transition: ${betterTransition};
           	''
       }
            }
            @keyframes gradient_horizontal {
      	0% {
      	  background-position: 0% 50%;
      	}
      	50% {
      	  background-position: 100% 50%;
      	}
      	100% {
      	  background-position: 0% 50%;
      	}
            }
            @keyframes swiping {
              0% {
      	  background-position: 0% 200%;
      	}
      	100% {
      	  background-position: 200% 200%;
      	}
            }
            tooltip {
      	background: #${palette.base00};
      	border: 1px solid #${palette.base0E};
      	border-radius: 10px;
            }
            tooltip label {
      	color: #${palette.base07};
            }
            #window {
      	${
         if slickbar == true then
           "  color: #${palette.base05};\n  background: #${palette.base00};\n  border-radius: 50px 15px 50px 15px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  color: #${palette.base03};\n  background: #${palette.base00};\n  margin: 6px 4px;\n  border-radius: 15px;\n  padding: 0px 10px;\n"
         else
           "  margin: 4px;\n  padding: 2px 10px;\n  color: #${palette.base05};\n  background: #${palette.base01};\n  border-radius: 10px;\n"
       }
            }
            #memory {
         	color: #${palette.base0F};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 50px 15px 50px 15px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #clock,
            #custom-watson {
          	color: #${palette.base0B};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 15px 50px 15px 50px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #cpu {
          	color: #${palette.base07};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 50px 15px 50px 15px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #disk {
          	color: #${palette.base03};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 15px 50px 15px 50px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #battery {
          	color: #${palette.base08};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 15px 50px 15px 50px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #network {
          	color: #${palette.base09};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 50px 15px 50px 15px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #custom-hyprbindings {
          	color: #${palette.base0E};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 15px 50px 15px 50px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #tray {
          	color: #${palette.base05};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 15px 0px 0px 50px;\n  margin: 5px 0px 5px 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #pulseaudio {
          	color: #${palette.base0D};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 50px 15px 50px 15px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #custom-notification {
          	color: #${palette.base0C};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 15px 50px 15px 50px;\n  margin: 5px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #custom-themeselector {
          	color: #${palette.base0D};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 0px 50px 15px 0px;\n  margin: 5px 0px;\n  padding: 2px 15px 2px 5px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px 6px 0px;\n  padding: 0px 10px 0px 5px;\n  border-radius: 0px 15px 15px 0px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px 0px;\n  padding: 2px 10px 2px 5px;\n  border-radius: 0px 10px 10px 0px;\n"
       }
            }
            #custom-startmenu {
          	color: #${palette.base03};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 0px 15px 50px 0px;\n  margin: 5px 5px 5px 0px;\n  padding: 2px 20px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 4px;\n  padding: 0px 8px 0px 10px;\n  border-radius: 15px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px;\n  padding: 2px 10px;\n  border-radius: 10px;\n"
       }
            }
            #idle_inhibitor {
          	color: #${palette.base09};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 0px;\n  margin: 5px 0px;\n  padding: 2px 14px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 0px;\n  padding: 0px 14px;\n  border-radius: 0px;\n"
         else
           "  background: #${palette.base01};\n  margin: 4px 0px;\n  padding: 2px 14px;\n  border-radius: 0px;\n"
       }
            }
            #custom-exit {
          	color: #${palette.base0E};
      	${
         if slickbar == true then
           "  background: #${palette.base00};\n  border-radius: 15px 0px 0px 50px;\n  margin: 5px 0px;\n  padding: 2px 5px 2px 15px;\n"
         else if simplebar == true then
           "  background: #${palette.base00};\n  margin: 6px 0px 6px 4px;\n  padding: 0px 5px 0px 10px;\n  border-radius: 15px 0px 0px 15px;\n"
         else ''
           background: #${palette.base01};
           margin: 4px 0px;
           padding: 2px 5px 2px 10px;
           border-radius: 10px 0px 0px 10px;
         ''
       }
            } ''];
  };
}
