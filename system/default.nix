{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./security.nix
    ./nvidia.nix
    ./audio.nix
    ./disk.nix
    ./sleep.nix
    ./font.nix
    ./wm.nix
    ./vm.nix
    ./3D.nix
  ];
}
