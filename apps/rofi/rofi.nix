{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    ## rofi-file-browser-extended ##
    xfce.exo
    ## rofi-calc ##
    libqalculate
    ## rofi-pass ##
    pinentry-rofi
  ];
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
      rofi-file-browser
      rofi-pass
      rofi-power-menu
    ];
    pass.enable = true;
    font = "Cascadia Code 12";
    theme = ./theme.rasi;
    extraConfig = {
      combi-modes = [ "drun" "run" ];
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = "Apps";
      drun-display-format = "{name}";
      scroll-method = 0;
      disable-history = false;
      sidebar-mode = false;
    };
  };
}
