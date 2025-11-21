{ nixpkgs, baseConfig, homeManager }:
{
  storage = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
       ./storage/configuration.nix
       baseConfig
       homeManager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.robbie = {
          imports = [ baseConfig.baseHomeManager ];
          programs.zellij.enable = nixpkgs.lib.mkForce false;
        };
       }
    ];
  };
}
