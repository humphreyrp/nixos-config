{
  nixpkgs,
  homeManager,
  common,
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    ./caddy.nix
    common.baseConfig
    homeManager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.robbie = {
        imports = [ common.homeManager.baseConfig ];
        programs.zellij.enable = nixpkgs.lib.mkForce false;
      };
    }
  ];
}
