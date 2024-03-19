{ config, pkgs, ... }:

{
  services.xserver = {
    displayManager = {
      defaultSession = "none+qtile";
      lightdm = {
        enable = true;
        greeters.mini = {
          enable = true;
          user = "jomor";
          extraConfig = ''
            [greeter]
            show-password-label = false
            [greeter-theme]
            background-image = "/home/jomor/Pictures/coolcat.png"
          '';
        };
      };
    };
    windowManager.qtile.enable = true;
  };

  environment.systemPackages = with pkgs; [
    qtile
    lightdm-mini-greeter
    #python311Packages.qtile-extras
    feh
  ];
}
