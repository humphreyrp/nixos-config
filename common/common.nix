{ pkgs }:
{
  baseHomeManager = import ./home-manager.nix { inherit pkgs; };
  baseConfig = import ./modules/base-config.nix { inherit pkgs; };
}
