{ config, lib, pkgs, ... }:

{
  options = { Nvidia.enable = lib.mkEnableOption "enables Nvidia"; };

  config = lib.mkIf config.Nvidia.enable {
    hardware = {
      ### OPENGL ###
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      ### NVIDIA ###
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
      };
    };
    services.xserver.videoDrivers = [ "nvidia" ];
  };

}
