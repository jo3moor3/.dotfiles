{ config, pkgs, inputs, pkgs-stable, ... }: {
  imports = [ ../apps/default.nix ];

  ### HOME-MANAGER ###
  programs.home-manager.enable = true;
  home.username = "jomor";
  home.homeDirectory = "/home/jomor";
  home.stateVersion = "23.11";

  ### A tidy $HOME is a tidy mind
  xdg.enable = true;

  ### KEYBINDINGS ###
  home.keyboard.options = [ "caps:super" ];

  ### IMPORTANT SERVICES ###
  xsession.enable = true; # x11 environment
  services = {
    udiskie.enable = true;
    cliphist.enable = true;
  }; # automount daemon

  ### GIT ###
  programs.git = {
    enable = true;
    userName = "jomor";
    userEmail = "jo3moore@gmail.com";
    extraConfig = { init.defaultBranch = "main"; };
  };
  ### VIRTUALIZATION ###
  # dconf.settings = {
  #   "org/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };

  ### USER PACKAGES ###
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    firefox # slightly better than other mainstream alternatives
    #discord # modern gamer skype
    #webcord-vencord
    pkgs-stable.figma-agent
    figma-linux
    #figma-agent
    webcord
    spotify
    #steam
    ### SCREEN SHOT ###
    hyprshot
    grim
    slurp
    jq
    #flameshot
    peek # screen recorder tool
    obs-studio
    obs-cli
    kooha
    kdePackages.okular
    pdfarranger
    glslviewer # shader editor/viewer
    kdePackages.gwenview # image viewer
    gimp # image editor
    krita
    inkscape # vector editor
    mpv # video player
    libsForQt5.kdenlive # video editor
  ];

}
