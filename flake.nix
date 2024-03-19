{
  description = "op flake";

  inputs = {
    # The quintessential packages
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    # The better stow. Configure all
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Allow persistance for when I nuke my computer on reboot
    # impermanence.url = "github:nix-community/impermanence";
    # impermanence.inputs.nixpkgs.follows = "nixpkgs";
    # Fixing dynamicallly linked executables, because nixos can't natively.
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    # when on the impermanence grind, add it back here
    { self, nixpkgs, nixpkgs-stable, home-manager, nix-ld, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      username = "jomor";
    in {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./profile/configuration.nix

            # impermanence.nixosModules.impermanence

            nix-ld.nixosModules.nix-ld
            #{programs.nix-ld.enable = true;} # please
          ];
          specialArgs = {
            inherit pkgs-stable;
            inherit username;
          };
        };
      };

      homeConfigurations = {
        jomor = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profile/home.nix ];
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit username;
          };
        };
      };

      apps."${system}".default = {
        type = "app";
        program = ./bin/hey;
      };
    };
}
