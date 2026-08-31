{
  nixpkgs,
  homeManager,
  common,
  commonHomeManager,
}:
{
  storage = import ./storage/storage.nix { inherit nixpkgs homeManager common; };
  otto = import ./otto/otto.nix { inherit nixpkgs homeManager common; };
  dev = import ./dev/dev.nix {
    inherit
      nixpkgs
      homeManager
      common
      commonHomeManager
      ;
  };
  backupServer = import ./backup-server/backup-server.nix { inherit nixpkgs homeManager common; };
  revProxy = import ./rev-proxy/rev-proxy.nix { inherit nixpkgs homeManager common; };
}
