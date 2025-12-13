{ ... }:
let
  filepath = "/data/public/immich";
in
{
  # Create the immich directory if it doesn't exist
  systemd.tmpfiles.rules = [
    "d ${filepath} 0755 immich immich - -"
  ];

  # Add to immich group
  users.users.robbie.extraGroups = [ "immich" ];

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

}
