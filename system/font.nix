{ config, lib, pkgs, pkgs-stable, ... }:

{
  fonts.fontDir.enable = true;

  environment.systemPackages = with pkgs; [ font-manager ];

  fonts.packages = with pkgs; [
    ## Rofi  font ##
    cascadia-code
    #corefonts
    ## Qtile+Kitty ##
    nerd-fonts.sauce-code-pro # Kitty/Ranger
    nerd-fonts.symbols-only
    # (nerdfonts.override {
    #   fonts = [
    #     "NerdFontsSymbolsOnly" # Qtile
    #   ];
    # })

    ## Emacs fonts ##
    jetbrains-mono
    alegreya
  ];
}
