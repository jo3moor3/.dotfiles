{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ];

  home.file = {
    ### Core configurations ###
    ".config/ranger/rc.conf".source = ./rc.conf; # config and keybindings
    ".config/ranger/rifle.conf".source = ./rifle.conf; # launcher
    ".config/ranger/commands.py".source = ./commands.py; # modules

    ### Color schemes ###
    ".config/ranger/colorschemes/dracula.py".source = ./colorschemes/dracula.py;
    ".config/ranger/colorschemes/__init__.py".source =
      ./colorschemes/__init__.py;
    ### Plugins ###
    ".config/ranger/plugins/__init__.py".source = ./plugins/__init__.py;
    ".config/ranger/plugins/zoxide/__init__.py".source =
      ./plugins/zoxide/__init__.py;
    ".config/ranger/plugins/ranger_devicons/__init__.py".source =
      ./plugins/ranger_devicons/__init__.py;
    ".config/ranger/plugins/ranger_devicons/devicons.py".source =
      ./plugins/ranger_devicons/devicons.py;
  };
}
