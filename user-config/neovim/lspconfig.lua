-- Shared defaults applied to every server
vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
})

vim.lsp.config('ltex', {
  filetypes = { 'markdown', 'text', 'gitcommit', 'plaintext' },
  settings = { ltex = { language = 'en-US' } },
})

vim.lsp.enable({
  'bashls',
  'clangd',
  'html',
  'lua_ls',
  'ltex',
  'nil_ls',
  'rubocop',
  'ruby_lsp',
  'rust_analyzer',
  'ts_ls',
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    -- Neovim 0.11+ provides defaults: K (hover), grn (rename),
    -- gra (code action), grr (references), gri (implementation).
    map('gD', vim.lsp.buf.declaration, 'LSP declaration')
    map('gd', vim.lsp.buf.definition, 'LSP definition')
    map('<space>f', function() vim.lsp.buf.format() end, 'LSP format')
    map('<space>il', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, 'LSP toggle inlay hints')
    map('<space>ld', function()
      vim.diagnostic.open_float({ scope = 'line' })
    end, 'Diagnostic float (line)')
  end,
})
