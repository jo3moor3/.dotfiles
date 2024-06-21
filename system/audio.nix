{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #pulseaudio
    #pulseaudioFull
    pavucontrol
    pamixer
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # alsa.enable = true;
    # jack.enable = true;
  };

  users.extraUsers.jomor.extraGroups = [ "audio" ];
  nixpkgs.config.pulseaudio = true;
}
