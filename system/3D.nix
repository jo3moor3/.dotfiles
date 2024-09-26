{ config, lib, pkgs, pkgs-stable, ... }:

{
  environment.systemPackages = with pkgs; [
    pureref
    steam-run
    ### DCC ###
    blender # the unstoppable foss force in 3D graphics
    libdecor
    ninja
    houdini # Procedural 3D powerhouse, plays well with linux
    ### ENGINES ###
    godot_4
    #godot3
    # Viewers
    f3d
    meshlab
    ### 3D CONNEXION SPACEMOUSE ###
    spacenavd
    spnavcfg
    libspnav
  ];
  hardware.spacenavd.enable = true;
}
