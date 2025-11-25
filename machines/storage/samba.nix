{ ... }:
{
  # Create a user for the samba share. Password is created imperatively with smbpasswd.
  users.groups.smbuser = {};
  users.users.smbuser = {
    isSystemUser = true;
    group = "smbuser";
  };

  users.users.robbie = {
    isNormalUser = true;
    description = "robbie";
    extraGroups = [
      "networkmanager"
      "wheel"
      "smbuser"
    ];
  };

  # Create the public share directory
  systemd.tmpfiles.rules = [
    "d /data 0776 smbuser smbuser - -"
    "d /data/public 0776 smbuser smbuser - -"
  ];

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        security = "user";
        "hosts allow" = "192.168.1. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "public" = {
        path = "/data/public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "smbuser";
        "force group" = "smbuser";
      };
    };
  };
}
