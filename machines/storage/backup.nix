{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    borgbackup
  ];

  # Setup a periodic backup. Requires secrets files to be populated at /root/borg
  services.borgbackup.jobs.publicBackup = {
    paths = [ "/data/public" ];
    repo = "ssh://nmlhh20k@nmlhh20k.repo.borgbase.com/./repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/borg/borgbase-passphrase";
    };
    environment = {
      BORG_RSH = "ssh -i /root/borg/id_ed25519-borgbase";
    };
    compression = "auto,lzma";
    startAt = "daily";
  };
}
