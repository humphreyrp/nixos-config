{
  nixpkgs,
  homeManager,
  common,
}:
{
  storage = import ./storage/storage.nix { inherit nixpkgs homeManager common; };
  otto = import ./otto/otto.nix { inherit nixpkgs homeManager common; };
  dell-9560 = import ./dell-9560/dell-9560.nix { inherit nixpkgs homeManager common; };
}
