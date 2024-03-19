{ config, lib, pkgs, ... }:

{
  fonts.fontDir.enable = true;

  environment.systemPackages = with pkgs; [ font-manager ];

  fonts.packages = with pkgs; [
    ## Rofi  font ##
    cascadia-code

    ## Qtile+Kitty ##
    (nerdfonts.override {
      fonts = [
        "SourceCodePro" # Kitty/Ranger
        "NerdFontsSymbolsOnly" # Qtile
      ];
    })

    ## Emacs fonts ##
    jetbrains-mono
    alegreya
  ];
}
