{ config, pkgs, ... }:
let
  myAliases = {
    ls = "eza --icons -l -T -L=1";
    htop = "btm";
    cat = "bat";
    ".." = "z ..";
    q = "exit";
    gbc = "nix-collect-garbage --delete-old";
    "gbc+" = "sudo nix-collect-garbage -d";
    cd = "z";
    cdi = "zi";
    grep = "rg";
    ### NIX PAXKAGE CONTROL ###
    #hey = "~/.dotfiles/bin/hey.sh";
    hey = "nh ";
    re = "os switch ~/.dotfiles";
    ho = "home switch ~/.dotfiles";
    u = "os switch --update ~/.dotfiles --ask";
    ### COMPOSITOR LAUNCHING ###
    w = "dbus-run-session Hyprland";
    x = "startx";
    part = "sudo -E gparted";
  };
in {

  home.packages = with pkgs; [
    ## TERMINAL ##
    kitty
    ## SHELL ##
    zsh
    shellcheck
    ### HEY ###
    #hello
    cached-nix-shell
    ### CONVENIENCE ###
    nix-zsh-completions
    zoxide
    fzf
    direnv
    nix-direnv
    ### AESTHETIC ###
    fastfetch # neofetch in C. Just better.
    #macchina # neofetch in rust. Needs to cook a lil more.
    oh-my-zsh # feeatureful zsh
    bat # prettier htop
    eza # prettier ls
    ### FUNCTION ###
    git
    bind
    unzip
    zip
    bottom
    ripgrep
    fd
    bc
    file
  ];

  programs = {
    ### TERMINAL ###
    kitty = {
      enable = true;
      font.name = "SauceCodePro Nerd Font";
      settings = { background_opacity = "0.8"; };
      extraConfig = ''
        include dracula.conf
        confirm_os_window_close 0
      '';
    };
    ### SHELL ###
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
    };

    zsh = {
      enable = true;
      shellAliases = myAliases;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "vi-mode" "zoxide" "poetry-env" ];
        theme = "agnoster";
      };
      initExtra = ''
        fastfetch
        export PATH=$PATH:$HOME/.config/emacs/bin
        export PATH=$PATH:$HOME/.local/share
        export PATH=$PATH:$HOME/.dotfiles/bin
      '';
      # for impermenance
      history = { path = "$HOME/.zsh_hist_dir/.zsh_history"; };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
  home.file.".config/fastfetch/config.jsonc".source = ./config.jsonc;
}
