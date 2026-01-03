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
      commonConfig = { pkgs, ...}: import ./common/common.nix { inherit pkgs; };
      systems = [ "x86_64-linux" "aarch64-linux" ];
      packages = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
          {
            inherit pkgs;
            common = commonConfig { inherit pkgs; };
          });
      machines = import ./machines/machines.nix {
        inherit nixpkgs homeManager;
        common = packages."x86_64-linux".common;
      };
    in
    {
      nixosConfigurations = machines;
      packages = packages;
      # formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
