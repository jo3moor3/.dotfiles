{ config, lib, pkgs, ... }:

{
home.packages = with pkgs; [
udiskie
];
  ### drive manager frontend ###
  services.udiskie = {
    enable = true;
    tray = "always";
    automount = true;
    notify = false;
  };
}
