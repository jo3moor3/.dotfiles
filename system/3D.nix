{ config, lib, pkgs, pkgs-stable, ... }:

{
  environment.systemPackages = with pkgs; [
    # dotnetCorePackages.dotnet_8.sdk
    # dotnetCorePackages.dotnet_8.runtime
    pureref
    #{ sha256 = "0iR1cP2sZvWWqKwRAwq6L/bmIBSYHKrlI8u8V2hANfM="; }
    ### DCC ###
    #blender # the unstoppable foss force in 3D graphics
    blender_4_2 # blender with cuda support prepackaged
    houdini # Procedural 3D powerhouse, plays well with linux(hopefully wayland as well soon)
    ### ENGINES ###
    godot # FOSS game enigne with wayland support
    #godot3
    # Viewers
    f3d # fast and widely compatible 3D viewer
    meshlab
    ### 3D CONNEXION SPACEMOUSE ###
    spacenavd # FOSS spacemouse driver
    spnavcfg # GUI for spacenavd
    libspnav # dependency for spacenavd
  ];
  hardware.spacenavd.enable = true;
}
