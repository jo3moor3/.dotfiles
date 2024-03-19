{ config, lib, pkgs, ... }:

{

  services.picom = {
    # Core
    enable = true;
    backend = "glx";
    vSync = true;
    # Fade
    fade = true;
    fadeSteps = [ 0.1 0.1 ]; # in-out
    # Shadows
    shadow = true;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"

      "_GTK_FRAME_EXTENTS@:c"
    ];
    settings = {
      shadow-radius = 7;
      shadow-offset-x = -7;
      shadow-offset-y = -7;
      corner-radius = 12.0;
      round-borders = 1;
      # Opacity
      inactiveOpacity = 1.0;
      frame-opacity = 1.0;
      inactive-opacity-override = false;
      focus-exclude = [ "class_g = 'Cairo-clock'" ];
      # Blur
      blur-size = 12;
      blur-background = true;
      blur-kern = "3x3box";
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
      # General
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      xrender-sync-fence = false;
      log-level = "warn";
      # Window Type
      wintypes = {
        tooltip = {
          fade = true;
          shadow = true;
          focus = true;
          full-shadow = false;
        };
        dock = { shadow = false; };
        dnd = { shadow = false; };
      };
    };

  };
  #home.packages = with pkgs; [ picom pcre2 ];
  #
  # nixpkgs.overlays = [
  #   (self: super: {

  #     picom = super.picom.overrideAttrs (oldAttrs: rec {
  #       version = "unstable-2021-10-23";
  #       src = super.fetchFromGitHub {
  #         owner = "pijulius";
  #         repo = "picom";
  #         rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
  #         sha256 = "sha256-YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
  #       };

  #       meta = with builtins.lib; {
  #         description = "A fork of picom featuring better animations";
  #         homepage = "https://github.com/pijulius/picom";
  #       };
  #     });
  #   })
  # ];

  # home.file.".config/picom/picom.conf".source = ./picom.conf;
}
