{ pkgs, ... }:
let baseBackup = {
      paths = [ "/data/public" ];
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /root/borg/borgbase-passphrase";
      };
      environment = {
        BORG_RSH = "ssh -i /root/borg/id_ed25519-borgbase";
      };
      compression = "auto,lzma";
    };
 in {
  environment.systemPackages = with pkgs; [
    borgbackup
  ];

  # Setup a periodic backups. We have two separate backups, one to a local borg repository and one
  # to one in the cloud. Requires secrets files to be populated at /root/borg.
  # Local backup every day
  services.borgbackup.jobs.backupLocal = baseBackup // {
    repo = "ssh://backup-server.localdomain/var/lib/storage_repo";
    startAt = "daily";
  };

  # Cloud backup every week
  services.borgbackup.jobs.backupCloud = baseBackup // {
    repo = "ssh://dm0t5su6@dm0t5su6.repo.borgbase.com/./repo";
    startAt = "weekly";
  };
}
