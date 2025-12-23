{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    caddy
  ];
}
