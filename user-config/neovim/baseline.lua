-- Leader keys (set before any plugin loads)
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- Directory nvim was launched from, captured before anything can change cwd
local launch_dir = vim.fn.getcwd()

local opt = vim.opt
opt.guicursor = ''
opt.relativenumber = true
opt.hidden = true
opt.number = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undodir = vim.fn.expand('~/.vim/undodir')
opt.undofile = true
opt.incsearch = true
opt.scrolloff = 8
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.autoindent = true
opt.errorbells = false
opt.visualbell = false
opt.colorcolumn = '80'
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.autoread = true
opt.clipboard = 'unnamedplus'
opt.showcmd = false
opt.encoding = 'utf8'
opt.fileformats = 'unix,dos,mac'
opt.backspace = { 'eol', 'start', 'indent' }
opt.whichwrap:append('<,>,h,l')
opt.hlsearch = true
opt.showmatch = true
opt.timeoutlen = 500
opt.synmaxcol = 1000
opt.listchars = { eol = '¬', tab = '>-', trail = '~', extends = '>', precedes = '<' }
opt.list = true
opt.breakindent = true
opt.breakindentopt = 'shift:2,min:40,sbr'
opt.linebreak = true
opt.shada:prepend('%')
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.laststatus = 3
opt.autochdir = false

vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  virtual_text = { prefix = '●' },
  signs = true,
  float = { border = 'rounded' },
})

local map = vim.keymap.set
map('n', '<leader>w', '<cmd>w!<cr>', { desc = 'Force write buffer' })
map({ 'n', 'v', 'o' }, '0', '^', { desc = 'Jump to first non-blank char' })
map({ 'n', 'v', 'o' }, '<space>', '/', { desc = 'Search forward' })
map({ 'n', 'v', 'o' }, '<c-space>', '?', { desc = 'Search backward' })
map('n', '<C-j>', '<C-W>j', { desc = 'Move to window below' })
map('n', '<C-k>', '<C-W>k', { desc = 'Move to window above' })
map('n', '<C-h>', '<C-W>h', { desc = 'Move to window left' })
map('n', '<C-l>', '<C-W>l', { desc = 'Move to window right' })

map('n', '<leader>p', function()
  require('telescope.builtin').find_files({ cwd = launch_dir })
end, { desc = 'Find files (launch dir)' })
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files (current cwd)' })
map('n', ';', '<cmd>Telescope buffers<cr>', { desc = 'List open buffers' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Search help tags' })
map('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { desc = 'List diagnostics' })
map('n', '<leader>?', '<cmd>Telescope keymaps<cr>', { desc = 'Keymap cheatsheet' })
map('n', '<leader>td', function() require('trouble').open('diagnostics') end, { desc = 'Trouble: workspace diagnostics' })
map('n', '<leader>tb', function() require('trouble').open('diagnostics_buffer') end, { desc = 'Trouble: buffer diagnostics' })
map('n', '<leader>ti', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = 'Toggle diagnostics' })

local tcione = vim.api.nvim_create_augroup('tcione', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = tcione,
  pattern = '*',
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  group = tcione,
  pattern = '*',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  pattern = '*',
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 700 })
  end,
})
