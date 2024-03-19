{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ];

  home.file = {
    ".config/ranger/rc.conf".source = ./rc.conf; # config and keybindings
    ".config/ranger/rifle.conf".source = ./rifle.conf; # launcher
    ".config/ranger/commands.py".source = ./commands.py; # core modules
  };
}
