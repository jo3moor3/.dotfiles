{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ### DCC ###
    blender # the unstoppable foss force in 3D graphics
    houdini # Procedural 3D powerhouse, plays well with linux
    ### ENGINES ###
    godot_4

    ### 3D CONNEXION SPACEMOUSE ###
    spacenavd
    spnavcfg
    libspnav
  ];
  hardware.spacenavd.enable = true;
}
