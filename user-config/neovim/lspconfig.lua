local nvim_lsp = require('lspconfig')

local on_lsp_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Enable LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

nvim_lsp.solargraph.setup({
  cmd = { "solargraph", "stdio" },
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.tsserver.setup({
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.rust_analyzer.setup({
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.bashls.setup({
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.clangd.setup({
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.svelte.setup({
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.gopls.setup({
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.html.setup({
  on_attach = on_lsp_attach,
  capabilities = capabilities,
})
nvim_lsp.ltex.setup({
  on_attach = on_lsp_attach,
  filetypes = {
    "markdown",
    "text",
    "gitcommit",
    "plaintext"
  },
  flags = {
    debounce_text_changes = 300
  },
  settings = {
    ltex = {
        language = "en-US"
    }
  }
})
