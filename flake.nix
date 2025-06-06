{
  description = "op flake";

  inputs = {
    ### The quintessential packages ###
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    ### The better stow. Configure all ###
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    blender-bin.url = "github:edolstra/nix-warez?dir=blender";
    blender-bin.inputs.nixpkgs.follows = "nixpkgs";
    ### Allow persistance for when I nuke my computer on reboot ###
    # impermanence.url = "github:nix-community/impermanence";
    # impermanence.inputs.nixpkgs.follows = "nixpkgs";

    ### ez Theming ###
    # stylix.url = "github:danth/stylix";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # hyprcursor-phinger = {
    #   url = "github:jappie3/hyprcursor-phinger";
    #   inputs.hyprland.follows = "hyprland";
    # };

    ## Fixing dynamicallly linked executables, because nixos can't natively. ###
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    ### secrets management ###
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    ### Secure boot through lanzaboote ###
    # lanzaboote.url = "github:nix-community/lanzaboote/v0.3.0";
    # lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    ## when on the impermanence grind, add it back here
    { self, nixpkgs, nixpkgs-stable, home-manager, blender-bin, ... }@inputs:
    let
      #inputs = self.inputs;
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
            inputs.nix-ld.nixosModules.nix-ld
            inputs.sops-nix.nixosModules.sops
            # inputs.lanzaboote.nixosModules.lanzaboote
            #inputs.impermanence.nixosModules.impermanence
            #inputs.stylix.nixosModules.stylix
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ blender-bin.overlays.default ];
            })
          ];
        };
      };

      homeConfigurations = {
        jomor = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./profile/home.nix ];
          extraSpecialArgs = {
            inherit pkgs-stable;
            inherit username;
            inherit inputs;
          };
        };
      };

      apps."${system}".default = {
        type = "app";
        program = ./bin/hey;
        executable = true;
      };
    };
}
