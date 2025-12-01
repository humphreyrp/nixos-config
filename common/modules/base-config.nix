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

    # Binary utilities
    patchelf
    toybox
    binutils
    pax-utils

    # Hardware utilities
    lshw
    busybox

    # System language servers
    lua-language-server
    dhall-lsp-server

    # Nix utilities
    nix-index
    nixd
    nix-tree
    nix-output-monitor
  ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  programs.ssh.extraConfig = ''
    Host *
        ServerAliveInterval 60
        ServerAliveCountMax 3
  '';

  # Run periodic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";

  # Will automatically build terminfo for any installed terminal emulators
  environment.enableAllTerminfo = true;
}
