{ nixpkgs, homeManager, common }:
{
  storage = import ./storage/top-level.nix { inherit nixpkgs homeManager common; };
}
