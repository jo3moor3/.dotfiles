{ config, lib, pkgs, ... }:

{
  ### drive manager frontend ###
  services.udiskie = {
    enable = true;
    tray = "always";
    automount = true;
    notify = false;
  };
}
