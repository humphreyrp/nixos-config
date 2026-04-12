{
  programs.zellij = {
    enable = true;
  };
  home.file.".config/zellij/config.kdl".source = ./zellij/config.kdl;
  home.file.".config/zellij/layouts/default.kdl".source = ./zellij/twopane-layout.kdl;
}
