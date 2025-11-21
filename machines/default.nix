{ nixpkgs, baseConfig, homeManager, baseHomeManager }:
{
  storage = import ./storage/top-level.nix { inherit nixpkgs baseConfig homeManager baseHomeManager; };
}
