{
  pkgs,
  lib,
  config,
  ...
}:
let
  tex = (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-medium csquotes librebaskerville; });
in
{
  options.enableTex = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable latex packages";
  };

  config.home.packages = lib.modules.mkIf config.enableTex [
    tex
  ];
}
