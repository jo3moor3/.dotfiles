{ config, lib, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs;
    [
      #discord # modern gamer skype
      webcord # works better with wayland + more privacy/features
      #webcord-vencord # extra plugins
    ];

  ### Transparent/dracula theme ###
  #home.file.".config/WebCord/Themes/op.theme" = { source = ./op.theme; };
}
