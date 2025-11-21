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
    { self, nixpkgs, homeManager }: rec
    {
      nixosModules = {
        default = ./modules/base-config.nix;
      };
      # TODO: Make this more sane
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      baseHomeManager = import ./home-manager.nix { inherit pkgs; };
      baseConfig = import ./modules/base-config.nix { inherit pkgs; };
      nixosConfigurations = {
        machines = import ./machines { inherit nixpkgs baseConfig homeManager baseHomeManager; };
      };
    };
}
