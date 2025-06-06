{ config, lib, pkgs, pkgs-stable, ... }:

{
  imports = [ ../system/default.nix ../secrets/secrets.nix ];

  ### BOOTLOADER ###
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ### NETWORKING ###
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable working.firewall.allowedTCPPorts = [ ... ];
  #networking.firewall.allowedUDPPorts = [ 5930 ];
  ## Or disable the firewall altogether.
  #networking.firewall.enable = false;

  ### INTERNATIONALISATION PROPERTIES ###
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  Nvidia.enable = true;
  Bluetooth.enable = false;

  systemd.user.services.emacs = {
    after = [ "graphical-session-pre.target" ];
    partOf = [ "graphical-session.target" ];
  };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  #services.xserver.digimend.enable = true;

  ### USER ACCOUNT ###
  users.users.jomor = {
    isNormalUser = true;
    description = "Jomor";
    extraGroups = [ "networkmanager" "wheel" "tss" ];
  };

  ### CORE PACKAGES ###
  nixpkgs.config = {
    allowUnfree = true; # Allow unfree packages
    #cudaSupport = true;
  };

  ## BLUETOOTH ##

  environment.systemPackages = with pkgs; [
    lm_sensors
    dmidecode
    vscode-fhs
    qbittorrent-enhanced
    libwacom
    evtest # input event debugging
    ### PRETTIER NIXPKGS ###
    nh # nix helper
    nix-output-monitor # downlaod visualizer
    nvd # nixOS diff tool
    #vimHugeX # vim with x support (+clipboard)
    vim # for when emacs fails
    #xmousepasteblock # disable middle mouse paste on x
    #polkit_gnome # authenticatoin agent
    kdePackages.polkit-kde-agent-1 # KDE > Gnome
    util-linux # system utilities
    xdg-utils
    libva-utils
    samba
    #epoll-shim
    python313
    coreutils # GNU utilities
    wget # file and recursive website downlaoder
    #ruby # GPL needed for hey script
    go
    gnumake # build tool
    cmake # build tool
    #libtool # generic library support
  ];

  ### DYNAMICALLY LINKED EXECUTABLES ###
  programs.nix-ld.dev = {
    enable = true;
    libraries = with pkgs; [
      curl
      sbcl # lisp
      codeium # AI language server
      libGL
      libva
      xorg.libxcb
      libexecinfo
      #steamPackages.steamcmd
      # ...
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  ### global enivironment variables ###

  ### STANDARD DEFAULTS ###
  security.polkit.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs = {
    zsh.enable = true;
    dconf.enable = true;
    mtr.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
