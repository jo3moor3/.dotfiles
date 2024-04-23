{ config, lib, pkgs, ... }:

{
  imports = [
    ./sh.nix
    ./emacs.nix
    ./light/nightlight.nix
    ./rofi/rofi.nix
    ./picom/picom.nix
    ./theme/theme.nix
    ./dunst/dunst.nix
    ./ranger/ranger.nix
    ./waybar.nix
    ./swaylock.nix
  ];
}
