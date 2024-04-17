{ config, lib, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = { exec-once = "${startupScript}/bin/start"; };
  };

}
