{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    dracula-theme
    dracula-icon-theme
    #nerdfonts
    qt5ct
    lxappearance
    apple-cursor
    libsForQt5.kcolorchooser
  ];

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk";
  };

  home.file.".config/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Dracula
    gtk-icon-theme-name=Dracula
    gtk-font-name=Sans 10
    gtk-cursor-theme-size=0
    gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-button-images=0
    gtk-menu-images=0
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle=hintmedium
    gtk-xft-rgba=none
  '';
}
