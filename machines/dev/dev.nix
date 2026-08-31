{
  nixpkgs,
  homeManager,
  common,
  commonHomeManager,
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    common
    homeManager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.robbie = {
        config.enableTex = true;
        imports = [
          commonHomeManager
        ];
      };
    }
  ];
}
