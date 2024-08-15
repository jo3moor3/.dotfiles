{ config, lib, pkgs, inputs, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    videoDrivers = [ "nvidia" ];
    windowManager.qtile = { enable = true; };
  };
  services.xserver.displayManager.startx.enable = true;

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
