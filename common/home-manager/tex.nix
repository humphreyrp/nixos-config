{ pkgs, ... }:
let
  tex = (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-medium csquotes librebaskerville; });
in
{
  home.packages = [
    tex
  ];
}
