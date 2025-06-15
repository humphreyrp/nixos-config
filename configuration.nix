{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tcpdump
    fuse
    netcat-gnu
    inetutils
    tshark
    dpkg
    tree
    fzf
    fd
    unzip
    btop
    sqlite
    rlwrap
    jq
    nix-tree

    # Hardware utilities
    lshw
    busybox

    # System language servers
    lua-language-server
    nixd

    # Useful search utility
    nix-index
  ];
}
