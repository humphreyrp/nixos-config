{
  description = "NixOS configurations for all of my nix machines";
  inputs = {
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
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      common = import ./common/common.nix { inherit pkgs; };
      machines = import ./machines/machines.nix { inherit nixpkgs homeManager common; };
    in
    {
      nixosConfigurations = machines;
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
