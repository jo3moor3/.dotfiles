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
    package = pkgs.pulseaudioFull;
    enable = true;
  };
  users.extraUsers.jomor.extraGroups = [ "audio" ];
  nixpkgs.config.pulseaudio = true;
}
