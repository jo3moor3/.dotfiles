{ config, pkgs, pkgs-stable, ... }: {
  imports = [ ../apps/default.nix ];

  ### HOME-MANAGER ###
  programs.home-manager.enable = true;
  home.username = "jomor";
  home.homeDirectory = "/home/jomor";
  home.stateVersion = "23.11";

  ### KEYBINDINGS ###
  home.keyboard.options = [ "caps:super" ];

  ### IMPORTANT SERVICES ###
  xsession.enable = true; # x11 environment
  services = { udiskie.enable = true; }; # automount daemon

  ### GIT ###
  programs.git = {
    enable = true;
    userName = "jomor";
    userEmail = "jo3moore@gmail.com";
    extraConfig = { init.defaultBranch = "main"; };
  };
  ### VIRTUALIZATION ###
  dconf.settings = {
    "org/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  wayland.windowManager.hyprland.enableNvidiaPatches = true;

  ### USER PACKAGES ###
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    firefox # slightly better than other mainstream alternatives
    #discord # modern gamer skype
    #webcord-vencord
    webcord
    ### SCREEN SHOT ###
    hyprshot
    grimblast
    wl-clipboard
    grim
    slurp
    jq
    #flameshot
    #peek # screen recorder tool
    glslviewer # shader editor/viewer
    gwenview # image viewer
    #gimp # image editor
    inkscape # vector editor
    mpv # video player
    libsForQt5.kdenlive # video editor
  ];

}
