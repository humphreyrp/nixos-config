{ pkgs, ... }:
let
  filepath = "/data/public/immich";
in
{
  # Create the immich directory if it doesn't exist
  systemd.tmpfiles.rules = [
    "d ${filepath} 0755 immich immich - -"
  ];

  users.users.robbie = {
    # Add to immich group
    extraGroups = [ "immich" ];
    packages = [
      pkgs.immich-cli
    ];
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    mediaLocation = "${filepath}";

    # Disable facial recognition for now until I get get better hardware support
    machine-learning = {
      enable = false;
    };
  };

  # Allow all local connections to have admin privileges.
  # TODO: Make this more fine grained
  services.postgresql.authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
}
