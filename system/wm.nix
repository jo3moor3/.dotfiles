{ config, lib, pkgs, inputs, ... }:

{
  ## X11 ###
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    videoDrivers = [ "nvidia" ];
    displayManager.startx.enable = true;
    windowManager.qtile = { enable = true; };
    exportConfiguration = true;
    autorun = false;
    xrandrHeads = [
      "HDMI-A-1"
      {
        output = "DP-3";
        primary = true;
      }
    ];
  };
  services.displayManager.enable = true;
  ## TTY ###
  services.getty.extraArgs = [ "--skip-login" ];
  services.getty.loginOptions = "-p -- jomor";

  environment.systemPackages = with pkgs; [
    ### X11 ###
    #qtile
    xorg.libX11
    xorg.xhost
    xclip
    feh
    libnotify
    meson
    ### WAYLAND ###
    wayland
    waydroid
    #wlroots_0_16
    #wl-clipboard
    hyprland-protocols
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    swaynotificationcenter
    swaybg
    wev
    wtype
    ydotool
    wlr-randr
  ];
}
