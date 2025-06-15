{
    description = "My NixOS base configuration";
    inputs = {
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs =
    {
        self,
        nixpkgs,
        home-manager,
	...
    }:
    {
        nixosModules = {
            default = ./modules/base-config.nix;
        };
	baseHomeManager = ./home-manager.nix;
    };
}
