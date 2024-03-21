{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender # the unstoppable foss force in 3D graphics
    #houdini # Procedural 3D powerhouse, plays well with linux

    ### 3D CONNEXION SPACEMOUSE ###
    spacenavd
  ];
  hardware.spacenavd.enable = true;
}
