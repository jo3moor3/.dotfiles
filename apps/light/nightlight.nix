{ config, lib, pkgs, ... }:

{
  # services.redshift = {
  #   enable = true;
  #   tray = true;
  #   provider = "manual";
  #   # latitude = 43.663793;
  #   # longitude = 79.428399;
  #   dawnTime = "6:00-7:45";
  #   duskTime = "18:45-20:15";
  #   temperature = {
  #     day = 6400;
  #     night = 3500;
  #   };
  # };
  home.packages = with pkgs; [ wlsunset hyprshade ];
  services.wlsunset = {
    enable = true;
    package = pkgs.wlsunset;
    latitude = "43.663793";
    longitude = "-79.428399";
    temperature = {
      night = 3500;
      day = 6400;
    };
  };
}
