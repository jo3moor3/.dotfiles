{ config, lib, pkgs, ... }:

{

  #home.packages = with pkgs; [ swaylock ];
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    #   sttings = {
    #       color = "808080";
    # font-size = 24;
    # indicator-idle-visible = false;
    # indicator-radius = 100;
    # line-color = "ffffff";
    # show-failed-attempts = true;
    #   };
  };
}
