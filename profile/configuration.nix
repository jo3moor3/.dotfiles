{ config, lib, pkgs, pkgs-stable, ... }:

{
  imports = [ ../system/default.nix ../secrets/secrets.nix ];

  ### BOOTLOADER ###
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ### NETWORKING ###
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable working.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  ## Or disable the firewall altogether.
  # networking.firewall.enable = false;

  ### INTERNATIONALISATION PROPERTIES ###
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  Nvidia.enable = true;

  ### USER ACCOUNT ###
  users.users.jomor = {
    isNormalUser = true;
    description = "Jomor";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  ### CORE PACKAGES ###
  nixpkgs.config.allowUnfree = true; # Allow unfree packages
  environment.systemPackages = with pkgs; [
    #vimHugeX # vim with x support (+clipboard)
    vim
    xmousepasteblock # disable middle mouse paste
    polkit_gnome # authenticatoin agent
    util-linux # system utilities
    xdg-utils
    libva-utils
    #libva
    coreutils # GNU utilities
    wget # file and recursive website downlaoder
    ruby # GPL needed for hey script
    gnumake # build tool
    cmake # build tool
    #libtool # generic library support
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = [ "*" ];
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };

  ### DYNAMICALLY LINKED EXECUTABLES ###
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      curl
      sbcl # lisp
      codeium # AI language server
      libGL
      libva
      xorg.libxcb
      # ...
    ];
  };

  ### global enivironment variables ###

  ### STANDARD DEFAULTS ###
  security.polkit.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs = {
    zsh.enable = true;
    dconf.enable = true;
    mtr.enable = true;
  };
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
