{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ];

  home.file = {
    ### Core configurations ###
    ".config/ranger/rc.conf".source = ./rc.conf; # config and keybindings
    ".config/ranger/rifle.conf".source = ./rifle.conf; # launcher
  };
  home.file.".config/ranger/commands.py" = {
    source = ./commands.py; # modules
    executable = true;
  };
  ### Color schemes ###
  home.file.".config/ranger/colorschemes/dracula.py" = {
    source = ./colorschemes/dracula.py;
    executable = true;
  };
  home.file.".config/ranger/colorschemes/__init__.py" = {
    source = ./colorschemes/__init__.py;
    executable = true;
  };
  ### Plugins ###
  home.file.".config/ranger/plugins/__init__.py" = {
    source = ./plugins/__init__.py;
    executable = true;
  };
  home.file.".config/ranger/plugins/zoxide/__init__.py" = {
    source = ./plugins/zoxide/__init__.py;
    executable = true;
  };
  home.file.".config/ranger/plugins/ranger_devicons/__init__.py" = {
    source = ./plugins/ranger_devicons/__init__.py;
    executable = true;
  };
  home.file.".config/ranger/plugins/ranger_devicons/devicons.py" = {
    source = ./plugins/ranger_devicons/devicons.py;
    executable = true;
  };
}
