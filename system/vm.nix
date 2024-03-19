{ config, lib, pkgs, username, ... }:

{
  #environment.systemPackages = with pkgs; [ virt-manager qemu ];
  programs.virt-manager.enable = true;
  virtualisation = { libvirtd.enable = true; };

  users.users.jomor.extraGroups = [ "libvirtd" ];
}
