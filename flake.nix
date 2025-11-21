{
  description = "My NixOS base configuration";
  inputs = { 
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
      baseHomeManager = ./home-manager.nix;
      baseConfig = import ./modules/base-config.nix { pkgs=nixpkgs; };
      machines = import ./machines { inherit nixpkgs baseConfig homeManager; };
    };
}
