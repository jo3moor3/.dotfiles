{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    #editors
    emacs29
    vim
    #neovim
    #dependencies
    sbcl
    ripgrep
    coreutils
    fd
    clang
    hunspell
    hunspellDicts.en_US
    hunspellDicts.fr-any
    maim
    xorg.xwininfo
    xdotool
    xclip
    shfmt
    gdtoolkit
    libxml2
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
  services = {
    emacs = {
      enable = true;
      package = pkgs.emacs29;
    };
  };
}
