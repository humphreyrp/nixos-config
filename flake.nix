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
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      machines = import ./machines/machines.nix {
        inherit nixpkgs homeManager;
        common = packages."x86_64-linux".common;
      };

      # Generate an output package set for all supported systems
      buildCommonConfig = { pkgs, ... }: import ./common/common.nix { inherit pkgs; };
      packages = nixpkgs.lib.genAttrs systems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          inherit pkgs;
          common = buildCommonConfig { inherit pkgs; };
        }
      );

      # Formatter for each system
      formatter = nixpkgs.lib.genAttrs systems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.nixfmt-rfc-style
      );
    in
    {
      nixosConfigurations = machines;
      inherit packages formatter;
    };
}
