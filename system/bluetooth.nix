{ config, lib, pkgs, ... }:

{

  options = { Bluetooth.enable = lib.mkEnableOption "enables bluetooth"; };

  config = lib.mkIf config.Bluetooth.enable {
    environment.systemPackages = with pkgs; [ hidapi ];
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
