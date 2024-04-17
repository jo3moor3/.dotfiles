{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
      patches = (oa.patches or [ ]) ++ [
        (pkgs.fetchpatch {
          name = "fix waybar hyprctl";
          url =
            "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
          sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
        })
      ];
    });
    style = ''
      * {
      	font-size: 20px;
      	font-family: monospace;
      }

      window#waybar {
      	background: #292b2e;
      	color: #fdf6e3;
      }

      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
      	color: #1a1a1a;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
      	color: #292b2e;
      	background: #1a1a1a;
      }

      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
      	background: #1a1a1a;
      }

      #workspaces button {
      	padding: 0 2px;
      	color: #fdf6e3;
      }
      #workspaces button.focused {
      	color: #268bd2;
      }
            #workspaces button.active {
              padding: 0 5px;
              color: #f1fa8c;
            }
            #workspaces button.empty {
              padding: 0 5px;
              color: #ff79c6;
            }
      #workspaces button:hover {
      	box-shadow: inherit;
      	text-shadow: inherit;
      }
      #workspaces button:hover {
      	background: #1a1a1a;
      	border: #1a1a1a;
      	padding: 0 3px;
      }

      #pulseaudio {
      	color: #268bd2;
      }
      #memory {
      	color: #2aa198;
      }
      #cpu {
      	color: #6c71c4;
      }
      #battery {
      	color: #859900;
      }
      #disk {
      	color: #b58900;
      }

      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
      	padding: 0 10px;
      }
    '';
    settings = {
      mainBar = {
        height = 30; # Waybar height (to be removed for auto height)
        # "width": 1280, # Waybar width
        spacing = 4; # Gaps between modules (4px)
        # Choose the order of the modules
        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
          "hyprland/scratchpad"
          "custom/media"
          "custom/right-arrow-dark"
          "hyprland/window"
        ];
        modules-center = [
          "custom/left-arrow-dark"
          "clock#1"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "clock#2"
          "custom/right-arrow-dark"
          "custom/right-arrow-light"
          "clock#3"
          "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "tray"
          "idle_inhibitor"
          #"network"
          "pulseaudio"
          "mpd"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "memory"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "cpu"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "battery"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
        ];
        "custom/left-arrow-dark" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/left-arrow-light" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right-arrow-dark" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/right-arrow-light" = {
          "format" = "";
          "tooltip" = false;
        };
        "clock#1" = {
          "format" = "{:%a}";
          "tooltip" = false;
        };
        "clock#2" = {
          "format" = "{:%H:%M}";
          "tooltip" = false;
        };
        "clock#3" = {
          "format" = "{:%m-%d}";
          "tooltip" = false;
        };
        ### MODULES CONFIG ###
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}: {icon}";
          "format-icons" = {
            # "1" = "";
            # "2" = "";
            # "3" = "";
            # "4" = "";
            # "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          # "icon-size": 21,
          spacing = 10;
        };
        clock = {
          #"timezone": "Canada/Toronto",
          format = "{:%I:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = "{:%Y-%m-%d}";
        };
        disk = {
          interval = 5;
          format = "Disk {percentage_used:2}%";
          path = "/";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = { "format" = "{}% "; };
        temperature = {
          # "thermal-zone" = 2,
          # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          # "format-critical" = "{temperatureC}°C {icon}";
          format = "{temperatureF}°F {icon}";
          format-icons = [ "" "" "" ];
        };
        backlight = {
          # "device": "acpi_video1",
          format = "{percent}% {icon}";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };
        # "battery"= {
        #     "states" = {
        #          "good" = 95;
        #         "warning" = 30;
        #         "critical" = 15;
        #     },
        #     "format" = "{capacity}% {icon}",
        #     "format-full" = "{capacity}% {icon}";
        #     "format-charging" = "{capacity}% ";
        #     "format-plugged" = "{capacity}% ";
        #     "format-alt" = "{time} {icon}";
        #     "format-good" = ""; # An empty format will hide the module
        #     "format-full" = "";
        #     "format-icons" = ["" "" "" "" ""];
        # },
        # "battery#bat2" = {
        #     "bat" = "BAT2";
        # };
        # "power-profiles-daemon" = {
        #   "format" = "{icon}";
        #   "tooltip-format" = "Power profile = {profile}\nDriver = {driver}";
        #   "tooltip" = true;
        #   "format-icons" = {
        #     "default" = "";
        #     "performance"= "";
        #     "balanced" = "";
        #     "power-saver" = "";
        #   };
        # };
        network = {
          # "interface" = "wlp2*"; # (Optional) To force the use of this interface
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          # "scroll-step": 1, // %, can be a float
          format = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "custom/media" = {
          "format" = "{icon} {}";
          "return-type" = "json";
          "max-length" = 40;
          "format-icons" = {
            "spotify" = "";
            "default" = "🎜";
          };
          escape = true;
          exec =
            "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
          # "exec" = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
        };
      };
    };
  };
}
