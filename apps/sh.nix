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
    hey = "~/.dotfiles/bin/hey.sh";
  };
in {

  home.packages = with pkgs; [
    ## Terminal ##
    kitty
    ## shell ##
    zsh
    # hey
    cached-nix-shell
    haskellPackages.shellwords
    haskellPackages.optparse-generic
    hello
    # convenience
    nix-zsh-completions
    zoxide
    fzf
    direnv
    nix-direnv
    # Aesthetic
    neofetch
    oh-my-zsh
    bat # htop
    eza
    #function
    git
    bind
    unzip
    bottom
    ripgrep
    fd
    bc
    shellcheck
    file
  ];

  programs = {
    ### Terminal ###
    kitty = {
      enable = true;
      font.name = "SauceCodePro Nerd Font";
      settings = { background_opacity = "0.8"; };
      extraConfig = ''
        include dracula.conf
        confirm_os_window_close 0
      '';
    };
    ### Shell ###
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
        neofetch
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
}
