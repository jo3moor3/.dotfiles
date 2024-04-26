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

  programs = {
    hyprland = {
      enable = true;
      #package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
  environment.sessionVariables = {
    # Fix invisible cursor
    HYPRLAND_LOG_WLR = "1";
    # Use electron apps with wayland
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    ### X11 ###
    qtile
    xorg.libX11
    feh
    ### WAYLAND ###
    #greetd.tuigreet
    hyprland-protocols
    qt6.qtwayland
    #libsForQt5.qt5.qtwayland
    swaynotificationcenter
    libnotify
    swaybg
    wev
    wtype
    ydotool
    wayland
    wlr-randr
    waydroid
  ];
}
