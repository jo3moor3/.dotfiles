{ config, lib, pkgs, ... }:

{

  programs.steam = {
    enable = true;
    package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    r2modman # for unity mods (BepInEX)
    ### GOG ###
    #heroic
    #gogdl
    ### GENERAL ###
    lutris
    mangohud # if you want stats in game
    protonup
    steamcmd
    steam-run # to run those that are allergic to linux
    ### WINE ###
    #wine-wayland
    wine
    wine64
    wine64Packages.wayland
    winetricks
    #server
    #xvfb-run
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/jomor/.steam/root/compatibilitytools.d";
  };

  programs.gamemode.enable = true;
}
