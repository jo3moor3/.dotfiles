{ config, lib, pkgs, ... }:

{

  programs.steam = {
    enable = true;
    package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    heroic
    gogdl
    mangohud
    protonup
    wine-wayland
    wine
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/jomor/.steam/root/compatibilitytools.d";
  };

  programs.gamemode.enable = true;
}
