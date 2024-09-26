{ config, lib, inputs, pkgs, ... }:

{

  home.packages = with pkgs; [ hyprland-protocols ];
  home.sessionVariables = {
    #Wayland
    HYPRLAND_LOG_WLR = "1"; # Fix invisible cursor
    NIXOS_OZONE_WL = "1"; # Use electron apps with wayland
    #QT
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    #QT_QPA_PLATFORMTHEME = "qt5ct"; # change to qt6ct if you have that
    #XDG
    XDG_SESSION_TYPE = "wayland";
    #GTK
    GDK_BACKEND = "wayland";
    #NVIDIA
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    #SDL_VIDEODRIVER="wayland"; # enable for certain games
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system};
    #   [
    #     hyprexpo
    #     #borders-plus-plus
    #   ];
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    extraConfig = ''
      # STARTUP VISUALS
      exec-once = swaync & udiskie & waybar
      #exec-once = swaybg -i ~/Pictures/coolcat.png
      exec-once = swaybg -i ~/Pictures/abstract.png
      exec-once = hyprshade auto

      # STARTUP ESSENTIALS
      exec-once = ${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1
      exec-once = dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE

      # STARTUP CLIPBOARD
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,preferred,auto,auto
      monitor=DP-3,1920x1080@143.99,0x0,1

      workspace=1,monitor:DP-3
      workspace=2,monitor:DP-3
      workspace=3,monitor:DP-3
      workspace=4,monitor:HDMI-A-1
      workspace=5,monitor:HDMI-A-1
      workspace=6,monitor:HDMI-A-1

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # VARIABLES
      $terminal = kitty
      $fileManager = kitty -e ranger
      $menu = rofi -show combi

      # Some default env vars.
      #env = XCURSOR_SIZE,28
      env = HYPRCURSOR_SIZE,28
      env = WLR_NO_HARDWARE_CURSORS,1

      exec-once = systemctl --user import-environment PATH


      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1
          mouse_refocus = false

          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 to 1.0, 0 means no modification.

      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(8BE9FDee) rgba(50FA7Bee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = dwindle

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10

          blur {
              enabled = true
              size = 3
              passes = 1
              #special = true
          }

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
          special_scale_factor = 0.5
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          #new_is_master = true
      }
      cursor {
          #enable_hyprcursor = 1
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      debug {
          disable_logs = false
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          #force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
          #initial_workspace_tracking = 0
          focus_on_activate = true
          #middle_click_paste = false
          initial_workspace_tracking = 0
          disable_hyprland_logo = true
          disable_splash_rendering = true
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }

      # Example windowrule v1
       #windowrule = maxsize 1000 1000, ^(kitty)$
       #windowrule = nomaximizerequest, ^(blender)$

       windowrule = float, ^(PureRef)$
       windowrule = minsize 500 500, ^(PureRef)$

       #windowrulev2 = float,class:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
       #windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # AUDIO
      bind = , XF86AudioRaiseVolume, exec, pamixer -i 5 @DEFAULT_SINK@ --allow-boost
      bind = , XF86AudioLowerVolume, exec, pamixer -d 5 @DEFAULT_SINK@
      bind = , XF86AudioMute, exec, pamixer -t
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous

      # STANDARD APPS
      bind = SUPERALT, return, exec, $terminal
      bind = $mainMod, B, exec,firefox
      bind = $mainMod, D, exec,webcord --disable-gpu
      bind = $mainMod, E, exec,emacsclient -c -a emacs
      bind = SUPER_SHIFT, E, exec,/home/jomor/.nix-profile/bin/emacs --daemon

      # UTILITIES
      ##pics
      bind = $mainMod, s, exec, hyprshot -m region
      bind = $mainMod, g, exec, hyprpicker --autocopy
      bind = $mainMod, c, exec, rofi -modi clipboard:~/.dotfiles/bin/cliphist-rofi-img -show clipboard -show-icons
      ##VM
      bind = SUPER_SHIFT, v, exec, /home/jomor/.dotfiles/bin/vm.sh
      ##tablet
      bind = SUPER_SHIFT, w, exec, /home/jomor/.dotfiles/bin/monitorlock.sh
      bind = SUPER_SHIFT, t, exec, /home/jomor/.dotfiles/bin/otd.sh

      # FILES
      bind = SUPER_SHIFT, F, exec, $fileManager
      bind = SUPERALT, space, exec, rofi -show recursivebrowser -show-icons
      bind = SUPERALT, F, exec, thunar
      bind = ALT, space, exec, $menu # App launcher
      bind = $mainMod, P, exec, rofi-pass # Pass

      # WINDOW
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, V, togglefloating,
      bind = SUPER_SHIFT, P, pseudo, # dwindle
      bind = SUPER_SHIFT, S, togglesplit, # dwindle
      bind = $mainMod, tab, fullscreen, 1
      bind = SUPER_SHIFT, tab, fullscreen,
      bind = $mainMod, space, cyclenext,

      bind = SUPER_SHIFT, H, movewindow, l
      bind = SUPER_SHIFT, L, movewindow, r
      bind = SUPER_SHIFT, K, movewindow, u
      bind = SUPER_SHIFT, J, movewindow, d

      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d

            # resize with LMB/RMB + dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
            # or with HJKL
      bind = SUPERALT, L, resizeactive, 10 0
      bind = SUPERALT, H, resizeactive, -10 0
      bind = SUPERALT, K, resizeactive, 0 -10
      bind = SUPERALT, J, resizeactive, 0 10

      # WORKSPACES
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # SCRATCHPADS (special workspace)
      workspace = special:term, on-created-empty:[float] kitty
      workspace = special:file, on-created-empty:[float] kitty -e ranger

      bind = $mainMod, return, togglespecialworkspace, term
      bind = $mainMod, F, togglespecialworkspace, file
    '';
  };

}
