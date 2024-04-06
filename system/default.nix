{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./security.nix
    ./Nvidia.nix
    ./audio.nix
    ./disk.nix
    ./sleep.nix
    ./font.nix
    ./wm.nix
    ./vm.nix
    ./3D.nix
  ];
}
