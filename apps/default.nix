{ config, lib, pkgs, ... }:

{
  imports = [
    ./sh.nix
    ./emacs.nix
    ./redshift.nix
    ./rofi/rofi.nix
    ./picom/picom.nix
    ./theme/theme.nix
    ./dunst/dunst.nix
    ./ranger/ranger.nix
  ];
}
