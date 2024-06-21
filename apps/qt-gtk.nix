{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    dracula-theme
    dracula-icon-theme
    #nerdfonts
    qt5ct
    #lxappearance
    nwg-look
    #phinger-cursors
    #hyprcursor
    hyprpicker
    #libsForQt5.kcolorchooser
  ];

  ### QT to GTK ###
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gtk";
  };

  gtk = {
    ### UI THEME ###
    enable = true;
    theme.name = "Dracula";
    iconTheme.name = "Dracula";
    font.name = "Sans 10";
    gtk3.extraConfig = {
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images = 0;
      gtk-menu-images = 0;
      gtk-enable-event-sounds = 1;
      gtk-enable-input-feedback-sounds = 1;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintmedium";
      gtk-xft-rgba = "none";
    };

    ### CURSOR THEME ###
    # cursorTheme.package = pkgs.phinger-cursors;
    # cursorTheme.name = "phinger-cursors";
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 14;
  };
}
