{ config, lib, pkgs, impermanence, ... }:

{
  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [ "/etc/machine-id" ];
    users.jomor = {
      directories = [
        ### HOME ###
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "org"
        "shaders"
        "code"
        "3D"
        ".zsh_hist_dir"
        ".codeium"
        ".dotfiles"
        ".mozilla"
        ".password-store"
        ### CONFIG ###
        ".config/autostart"
        ".config/blender"
        ".config/gtk-3.0"
        ".config/qt5ct"
        ".config/git"
        ".config/direnv"
        ".config/dconf"

        ".config/doom"
        ".config/emacs"
        ".config/qtile"
        ".config/rofi"
        ".config/picom"
        ".config/dunst"
        ".config/kitty"
        ".config/discord"

        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".nixops";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ### LOCAL SHARE ###
        #".local/share/direnv"
        ".local/share/fonts"
        ".local/share/ranger"
        ".local/share/rofi"
        ".local/share/Trash"
        ".local/share/baloo"
        ".local/share/kxmlgui5"
        ".local/share/virtualenv"
        ".local/share/virtualenvs"
        ".local/share/zoxide"
      ];
      files = [ ".fehbg" "flameshot.sh" ".config/mimeapps.list" ".gtkrc-2.0" ];
    };
  };
}
