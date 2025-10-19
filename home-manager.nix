{ pkgs, lib, ... }:
let
  tex = (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-medium csquotes librebaskerville; });
in
{
  home.username = "robbie";
  home.homeDirectory = "/home/robbie";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.fzf
    pkgs.ripgrep
    pkgs.virtualenv
    tex
    (pkgs.writeShellScriptBin "launch-nix-shell" (
      lib.fileContents ./home-manager/scripts/launch-nix-shell
    ))
    (pkgs.writeShellScriptBin "launch-dev-shell" (
      lib.fileContents ./home-manager/scripts/launch-dev-shell
    ))
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Robert Humphrey";
    userEmail = "humphreyrp92@gmail.com";
    aliases = {
      re = "reset --hard HEAD";
      lb = "!r() { refbranch=\$1 count=\$2; git for-each-ref --sort=-committerdate refs/heads --format='%(refname:short)|%(HEAD)%(color:yellow)%(refname:short)|%(color:bold green)%(committerdate:relative)|%(color:blue)%(subject)|%(color:magenta)%(authorname)%(color:reset)' --color=always --count=\${count:-20} | while read line; do branch=\$(echo \"\$line\" | awk 'BEGIN { FS = \"|\" }; { print \$1 }' | tr -d '*'); ahead=\$(git rev-list --count \"\${refbranch:-origin/master}..\${branch}\"); behind=\$(git rev-list --count \"\${branch}..\${refbranch:-origin/master}\"); colorline=\$(echo \"\$line\" | sed 's/^[^|]*|//'); echo \"\$ahead|\$behind|\$colorline\" | awk -F'|' -vOFS='|' '{\$5=substr(\$5,1,70)}1' ; done | ( echo \"ahead|behind|branch|lastcommit|message|author\n\" && cat) | column -ts'|';}; r";
      cp = "cherry-pick";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      la = "ls -latr";
      gis = "git status";
      gap = "git add -p";
      lds = "launch-dev-shell";
      lns = "launch-nix-shell";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "my-gnzh";
      custom = "$HOME/.config/oh-my-zsh";
      extraConfig = ''
        if command -v zellij &> /dev/null
        then
          eval "$(zellij setup --generate-auto-start zsh)"
        fi
      '';
    };
  };
  home.file.".config/oh-my-zsh/themes/my-gnzh.zsh-theme".source = ./home-manager/my-gnzh.zsh-theme;

  programs.vim = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      vscode-nvim
      telescope-nvim
      telescope-file-browser-nvim
      haskell-vim
      auto-session
      nvim-cmp
      cmp-nvim-lsp
      ultisnips
      vim-gitgutter
      vim-better-whitespace
      comment-nvim
      blamer-nvim
      nvim-web-devicons
      vim-sleuth
      vim-surround
    ];
  };
  home.file.".config/nvim/init.lua".source = ./home-manager/init.lua;

  programs.zellij = {
    enable = true;
  };
  home.file.".config/zellij/config.kdl".source = ./home-manager/zellij/config.kdl;
  home.file.".config/zellij/layouts/default.kdl".source = ./home-manager/zellij/fivepane-layout.kdl;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
