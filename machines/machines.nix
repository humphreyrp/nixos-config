{
  nixpkgs,
  homeManager,
  common,
}:
{
  storage = import ./storage/storage.nix { inherit nixpkgs homeManager common; };
  automation-server = import ./automation-server/automation-server.nix { inherit nixpkgs homeManager common; };
  dell-9560 = import ./dell-9560/dell-9560.nix { inherit nixpkgs homeManager common; };
}
