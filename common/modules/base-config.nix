{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    fuse
    dpkg
    tree
    fzf
    fd
    unzip
    btop
    htop
    sqlite
    rlwrap
    jq
    file
    ghostty

    # Networking
    tshark
    tcpdump
    inetutils
    wget
    ethtool
    nmap
    dig

    # Binary utilities
    patchelf
    toybox
    binutils
    pax-utils

    # Hardware utilities
    lshw
    busybox
    parted

    # System language servers
    lua-language-server
    dhall-lsp-server

    # Nix utilities
    nix-index
    nixd
    nix-tree
    nix-output-monitor
    nix-your-shell
  ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  programs.ssh.extraConfig = ''
    Host *
        ServerAliveInterval 60
        ServerAliveCountMax 3
  '';

  # Run periodic garbage collection
  # Note: I'm always in a fight to clear space in the nix store. A trick that I've found is to
  # make sure I'm deleting my development build products that might hang around my file system. To
  # do that, I'll run `find . -type l -xtype d -name result -delete` periodically, which deletes
  # any result symlinks.
  # Also, it helps to sort the root filesystem to look for particularly bulk files and directories
  # with `sudo du -h / | sort -rh | head -n 20`, then if there are any suspicious nix closures,
  # check the gc root causing them to hang around with `nix-store --query --roots <store-path>.
  # Also, nix will store caches of data under `~/.cache` which can be bulky. Helps to clear those
  # out periodically.
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";

  # Setup zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Will automatically build terminfo for any installed terminal emulators
  environment.enableAllTerminfo = true;
}
