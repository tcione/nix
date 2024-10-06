{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;

    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.yaml-language-server
      rubyPackages.solargraph
      shellcheck
      rust-analyzer
      nil
      gnumake
      clang-tools
      gopls
      nodePackages_latest.vscode-langservers-extracted
      ltex-ls
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup({
            highlight = { enable = true }
          })
        '';
      }

      # Telescope
      plenary-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local actions = require('telescope.actions')
          local telescope = require('telescope')
          telescope.load_extension('fzf')
          telescope.setup({
            defaults = {
              mappings = {
                i = {
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous,
                },
              },
            }
          })
        '';
      }
      telescope-fzf-native-nvim

      # LSP
      {
        plugin = lsp-colors-nvim;
        type = "lua";
        config = ''
          require("lsp-colors").setup({
            Error = "#db4b4b",
            Warning = "#e0af68",
            Information = "#0db9d7",
            Hint = "#10B981"
          })
        '';
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = ''
          require("trouble").setup({
            fold_open = "v",
            fold_closed = ">",
            indent_lines = true,
            icons = false,
            signs = {
                error = "error",
                warning = "warn",
                hint = "hint",
                information = "info"
            },
            use_lsp_diagnostic_signs = false
          })
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile(./neovim/lspconfig.lua);
      }

      # Snippets
      friendly-snippets
      {
        plugin = luasnip;
        type = "lua";
        config = ''
          require("luasnip.loaders.from_vscode").lazy_load()
        '';
      }

      # Complete
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile(./neovim/nvim-cmp.lua);
      }

      # Random
      {
        plugin = vim-test;
        config = ''
          let g:test#strategy = 'neovim'
          let g:test#neovim#start_normal = 1
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require'lualine'.setup({
            options = { theme = 'jellybeans' }
          })
        '';
      }
      {
        plugin = vim-hexokinase;
        config = ''
          let g:Hexokinase_highlighters = ['backgroundfull']
        '';
      }
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          require("catppuccin").setup({})
          vim.cmd.colorscheme "catppuccin"
        '';
      }
      {
        plugin = nerdcommenter;
        config = ''
          let g:NERDDefaultAlign = 'left'
          let g:NERDSpaceDelims = 1
        '';
      }
      {
        plugin = zen-mode-nvim;
        type = "lua";
        config = builtins.readFile(./neovim/zen-mode.lua);
      }
      {
        plugin = oil-nvim;
        type = "lua";
        config = builtins.readFile(./neovim/oil-nvim.lua);
      }
      quickfix-reflector-vim
      vim-eunuch
      vim-fugitive
      BufOnly-vim
      PreserveNoEOL
      ferret
    ];
    extraConfig = builtins.readFile(./neovim/baseline.vim);
    extraLuaConfig = ''
    '';
  };

}
