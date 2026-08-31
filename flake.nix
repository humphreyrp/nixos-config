{
  description = "NixOS configurations for all of my nix machines";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=8c50a710ddca43d7a530fb805ad55bde8d0141c5";
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
      common = ./common/modules/base-config.nix;
      commonHomeManager = ./common/home-manager/home-manager.nix;
      machines = import ./machines/machines.nix {
        inherit
          nixpkgs
          homeManager
          common
          commonHomeManager
          ;
      };
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
      inherit formatter;
    };
}
