{ pkgs }:
{
  homeManager = {
    baseConfig = import ./home-manager.nix { inherit pkgs; };
    tex = import ./home-manager/tex.nix { inherit pkgs; };
  };
  baseConfig = import ./modules/base-config.nix { inherit pkgs; };
  ghostty-terminfo = ./resources/ghostty-terminfo;
}
