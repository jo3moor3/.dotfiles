{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
    pamixer
    pulseaudioFull
  ];
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    #hardware.pulseaudio.support32Bit = true;
  };
  users.extraUsers.jomor.extraGroups = [ "audio" ];
  nixpkgs.config.pulseaudio = true;
}
