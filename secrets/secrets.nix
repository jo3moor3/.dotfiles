{ config, inputs, ... }:

{
  #imports = [ inputs.sops-nix.nixosModules.sops ];
  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/jomor/.config/sops/age/keys.txt";

  sops.secrets.password_jomor.neededForUsers = true;
  users.users.jomor = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.password_jomor.path;
  };
}
