{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./security.nix
    ./nvidia.nix
    ./audio.nix
    ./sleep.nix
    #./secrets.nix
    ./font.nix
    ./wm.nix
    ./vm.nix
  ];
}
