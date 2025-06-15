{
  description = "My NixOS base configuration";
  inputs = { };
  outputs =
    { self }:
    {
      nixosModules = {
        default = ./modules/base-config.nix;
      };
      # TODO: Can I make this a module?
      baseHomeManager = ./home-manager.nix;
    };
}
