{
  nixpkgs,
  homeManager,
  common,
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  description = "Development NixOS configuration";
  modules = [
    ./configuration.nix
    common.baseConfig
    homeManager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.robbie = {
        imports = [
          common.homeManager.baseConfig
          common.homeManager.tex
        ];
      };
    }
  ];
}
