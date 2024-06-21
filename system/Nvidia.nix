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
        nvidiaSettings = true;
      };
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    boot = {
      initrd.kernelModules =
        [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      kernelParams = [
        # Nvidia framebuffer.
        "nvidia-drm.fbdev=1"
        #allows the driver to take full advantage of the PAT technology - a newer way of allocating memory. Default is =0.
        "nvidia.NVreg_UsePageAttributeTable=1"
        #For testing purposes.
        #"nvidia.NVreg_EnableGpuFirmware=1"
      ];
    };
  };
}
