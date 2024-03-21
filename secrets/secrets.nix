{ config, pkgs, ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/jomor/.config/sops/age/keys.txt";

  sops.secrets.password_jomor.neededForUsers = true;
  users.users.jomor = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.password_jomor.path;
  };
  environment.systemPackages = with pkgs; [ sops age pass gnupg pinentry ];

  services = { openssh.enable = true; };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
