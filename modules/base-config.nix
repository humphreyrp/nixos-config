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
    nix-tree
    file

    # Networking
    tshark
    tcpdump
    inetutils
    wget
    ethtool

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
    nixd

    # Useful search utility
    nix-index
  ];

  # Enable the OpenSSH daemon
  services.openssh.enable = true;
}
