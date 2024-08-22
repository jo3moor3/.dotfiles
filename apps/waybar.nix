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
      	font-size: 16px;
      	font-family: mono, FontAwesome6Free, SymbolsNerdFont;
      }
      window#waybar {
        background: rgba(68, 71, 90, 1);
      	color: #F8F8F2;
      }

      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
      	color: #282A36;
        background: rgba(68, 71, 90, 1);
        font-family: FontAwesome6Free;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
        color: rgba(68, 71, 90, 1);
      	background: #282A36;
        font-family: FontAwesome6Free;
      }

      #custom-nightlight {
      	background: #282A36;
      }
      #custom-notification {
        background: #282A36;
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
      	background: #282A36;
      }

      #workspaces button {
      	padding: 0 2px;
      	color: #F8F8F2;
      }
      #workspaces button.focused {
      	color: #f1fa8c;
      }
      #workspaces button.active {
        padding: 0 2px;
      	color: #f1fa8c;
            }
      #workspaces button.empty {
        padding: 0 2px;
      	color: #F8F8F2;
            }
      #workspaces button:hover {
      	box-shadow: inherit;
      	text-shadow: inherit;
      }
      #workspaces button:hover {
      	background: #282A36;
      	border: #282A36;
      	padding: 0 3px;
      }

      #pulseaudio {
      	color: #8BE9FD;
      }
      #memory {
      	color: #50FA7B;
      }
      #cpu {
      	color: #BD93F9;
      }
      #battery {
      	color: #859900;
      }
      #disk {
      	color: #FFB86C;
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
        #spacing = 4; # Gaps between modules (4px)
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
          #"idle_inhibitor"
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
          "tray"
          "custom/nightlight"
          "custom/notification"
        ];
        "custom/notification" = {
          "tooltip" = false;
          "format" = " {icon}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
            "inhibited-notification" =
              "<span foreground='red'><sup></sup></span>";
            "inhibited-none" = "";
            "dnd-inhibited-notification" =
              "<span foreground='red'><sup></sup></span>";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
        };
        "custom/nightlight" = {
          "return type" = "json";
          "format" = "  {} ";
          "exec" = "~/.dotfiles/apps/light/sunONOFF.sh";
          "on-click" = "hyprshade toggle";
          "restart-interval" = 1;
          "tooltip" = false;
        };
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
          "format" = "{:%I:%M}";
          "tooltip" = false;
        };
        "clock#3" = {
          "format" = "{:%m-%d}";
          "tooltip" = false;
        };
        ### MODULES CONFIG ###
        "hyprland/workspaces" = {
          disable-scroll = true;
          #all-outputs = true;
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
          };
          warp-on-scroll = false;
          format = "{icon}";
          "format-icons" = {
            # "1" = "";
            # "2" = "";
            # "3" = "";
            # "4" = "";
            # "5" = "";
            "empty" = "";
            "default" = "";
            "active" = "";
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
          "format-muted" = "󰝟 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = " ";
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
