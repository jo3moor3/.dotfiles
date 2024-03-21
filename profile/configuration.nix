{ config, lib, pkgs, pkgs-stable, ... }:

{
  imports = [ ../system/default.nix ../secrets/secrets.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # services for ssh and x11
  services = {
    openssh.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    # automount external drives
    gvfs.enable = true;
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jomor = {
    isNormalUser = true;
    description = "Jomor";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  ### Core packages ###
  environment.systemPackages = with pkgs; [
    flameshot # screenshot utility
    vlc # video player
    mpv # video player
    discord # modern gamer skype
    wget
    ruby # for hey script
    gnumake # build tool
    #cmake
    #libtool
    ## DRIVES ##
    gparted # partition manager
    gvfs # automounting drives
    udisks # drive manager backend
    udiskie # drive manager frontend
  ];

  hardware.spacenavd = true;

  # Fixing compatibility with DLEs
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      curl
      # for lisp and emacs codeium
      sbcl
      codeium
      # ...
    ];
  };

  # enabling important programs
  users.defaultUserShell = pkgs.zsh;
  programs = {
    zsh.enable = true;
    dconf.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
  };

  # garbage collection
  nix = {
    settings.auto-optimise-store = true; # To run after every build
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-5d";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
