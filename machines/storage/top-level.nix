{ nixpkgs, baseConfig, homeManager, baseHomeManager }:
{
  topLevel = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
       ./configuration.nix
       baseConfig
       homeManager.nixosModules.home-manager {
         home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.users.robbie = {
           imports = [ baseHomeManager ];
           programs.zellij.enable = nixpkgs.lib.mkForce false;
         };
       }
    ];
  };
}
