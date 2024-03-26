{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gparted # partition manager
    gvfs # automounting drives
    udisks # drive manager backend
    udiskie # drive manager frontend
    libsForQt5.filelight # Visualizing disk usage
    libsForQt5.ark # For extracting archives
    ntfs3g # For reading NTFS filesystems
  ];

  ### AUTOMOUNTING ###
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };
  boot.supportedFilesystems = [ "ntfs" ];
  ### GUI FILE MANAGER ###
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

  ### GARBAGE COLLECTION ###
  nix = {
    settings.auto-optimise-store = true; # To run after every build
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-5d";
    };
  };
}
