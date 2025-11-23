{
  nixpkgs,
  homeManager,
  common,
}:
{
  storage = import ./storage/storage.nix { inherit nixpkgs homeManager common; };
}
