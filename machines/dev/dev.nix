{
  nixpkgs,
  homeManager,
  common,
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    common.baseConfig
    homeManager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.robbie = {
        config.enableTex = true;
        imports = [
          common.homeManager.baseConfig
        ];
      };
    }
  ];
}
