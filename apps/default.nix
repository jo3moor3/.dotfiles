{ config, lib, pkgs, ... }:

{
  imports = [
    ./sh.nix
    ./emacs.nix
    ./light/nightlight.nix
    ./rofi/rofi.nix
    ./picom/picom.nix
    ./qt-gtk.nix
    ./dunst/dunst.nix
    ./ranger/ranger.nix
    ./waybar.nix
    ./udiskie.nix
    ./hyprland/hyprland.nix
  ];
}
