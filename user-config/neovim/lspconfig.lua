-- Global LSP debounce
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
    debounce_text_changes = 300,
  }
)

local on_lsp_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('n', '<space>il', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', opts)
  buf_set_keymap('n', '<space>ld', '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.lsp.config('ruby_lsp', { on_attach = on_lsp_attach, capabilities = capabilities, })
vim.lsp.enable('ruby_lsp')

vim.lsp.config('rubocop', { on_attach = on_lsp_attach, capabilities = capabilities, })
vim.lsp.enable('rubocop')

vim.lsp.config('ts_ls', { on_attach = on_lsp_attach, capabilities = capabilities, })
vim.lsp.enable('ts_ls')

vim.lsp.config('rust_analyzer', { on_attach = on_lsp_attach, capabilities = capabilities, })
vim.lsp.enable('rust_analyzer')

vim.lsp.config('bashls', { on_attach = on_lsp_attach, capabilities = capabilities, })
vim.lsp.enable('bashls')

vim.lsp.config('html', { on_attach = on_lsp_attach, capabilities = capabilities, })
vim.lsp.enable('html')

vim.lsp.config('lua_ls', {
  on_attach = on_lsp_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }
    }
  }
})
vim.lsp.enable('lua_ls')

vim.lsp.config('nil_ls', { on_attach = on_lsp_attach, capabilities = capabilities, })
vim.lsp.enable('nil_ls')

vim.lsp.config('ltex', {
  on_attach = on_lsp_attach,
  capabilities = capabilities,
  filetypes = {
    "markdown",
    "text",
    "gitcommit",
    "plaintext"
  },
  flags = {
    debounce_text_changes = 3000
  },
  settings = {
    ltex = {
      language = "en-US"
    }
  }
})
vim.lsp.enable('ltex')
