{ config, lib, pkgs, inputs, ... }:

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "jomor";
in {

  services.xserver.enable = true;
  services.xserver.windowManager.qtile = { enable = true; };

  security.pam.services.swaylock = { };
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };
      default_session = {
        command =
          "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };

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
    greetd.tuigreet

    #swaylock
    hyprland-protocols
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols
    #kdePackages.waylib
    where-is-my-sddm-theme
    qt6.qtwayland
    qtile
    swaynotificationcenter
    libnotify
    swaybg
    wev
    wtype
    ydotool
    wayland
    wlr-randr
    waydroid
    feh
  ];
}
