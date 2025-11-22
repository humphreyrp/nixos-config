{
  description = "My NixOS base configuration";
  inputs = rec {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      homeManager,
    }:
    rec {
      # TODO: Make this more sane
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      common = import ./common/common.nix { inherit pkgs; };
      nixosModules = {
        default = ./modules/base-config.nix;
      };
      nixosConfigurations = {
        machines = import ./machines { inherit nixpkgs homeManager common; };
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
