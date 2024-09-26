{ config, lib, pkgs, ... }:

{

  programs.steam = {
    enable = true;
    package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    r2modman
    heroic
    lutris
    gogdl
    mangohud
    protonup
    #wine-wayland
    wine
    wine64
    wine64Packages.wayland
    winetricks
    #server
    #xvfb-run
    steamPackages.steamcmd
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/jomor/.steam/root/compatibilitytools.d";
  };

  programs.gamemode.enable = true;
}
