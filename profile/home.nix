{ config, pkgs, pkgs-stable, ... }: {
  imports = [ ../apps/default.nix ];

  ### home-manager configuration ###
  programs.home-manager.enable = true;
  home.username = "jomor";
  home.homeDirectory = "/home/jomor";
  home.stateVersion = "23.11";

  ### keybindings ###
  home.keyboard.options = [ "caps:super" ];

  ### important services ###
  xsession.enable = true;
  services = {
    udiskie.enable = true;
    gpg-agent.enable = true;
  };

  ### git setup ###
  programs.git = {
    enable = true;
    userName = "jomor";
    userEmail = "jo3moore@gmail.com";
    extraConfig = { init.defaultBranch = "main"; };
  };

  ### Virtualization config ###
  dconf.settings = {
    "org/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  ### Packages ###
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    firefox
    discord
    glslviewer
    libsForQt5.filelight
    libsForQt5.ark
    gwenview
    #libsForQt5.kdenlive
    ntfs3g
    util-linux
    blender # the unstoppable foss force in 3D graphics

    #houdini # Procedural 3D powerhouse, plays well with linux
    #gimp
    inkscape
  ];

  ### global enivironment variables ###
  home.sessionVariables = { EDITOR = "vim"; };
}
