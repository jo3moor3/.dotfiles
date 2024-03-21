{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    emacs29
    ### CORE ###
    sbcl
    clang
    xorg.xwininfo
    xdotool
    xclip
    ### SPELLCHECKER ###
    hunspell
    hunspellDicts.en_US
    hunspellDicts.fr-any
    ### ORG DOWNLOAD ###
    maim
    ### LANGUAGE SUPPORT ###
    shfmt # shell
    gdtoolkit # gdscript
    libxml2 # xml
    #Python
    poetry
    black
    pipenv
    nodePackages.pyright
    python311Packages.nose
    python311Packages.isort
    python311Packages.pip
    python311Packages.pyflakes
    python311Packages.pytest
    #nix
    nil
    nixfmt
  ];
  services.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };
}
