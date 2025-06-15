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
    }:
    let
    in
    {
        nixosModules = {
            default = ./configuration.nix;
        };
    };
}
