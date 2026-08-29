{ pkgs, ... }:
{
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
      vim-gitgutter
      vim-better-whitespace
      comment-nvim
      blamer-nvim
      nvim-web-devicons
      vim-sleuth
      vim-surround
      nvim-scrollbar
      rustaceanvim
      lualine-nvim
      render-markdown-nvim
      diffview-nvim
    ];
    initLua = "require('custom-init')";
  };
  home.file.".config/nvim/lua/custom-init.lua".source = ./nvim/custom-init.lua;
}
