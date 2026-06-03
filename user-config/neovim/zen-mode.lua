require("zen-mode").setup({
  window = {
    width = 80,
    height = 1,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      colorcolumn = "",
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = true,
      showcmd = false,
      spell = true,
    },
    twilight = { enabled = false },
    kitty = { enabled = false },
  },
  on_open = function()
    require('cmp').setup.buffer({ enabled = false })
  end,
  on_close = function()
    require('cmp').setup.buffer({ enabled = true })
  end,
})

vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<cr>', { desc = 'Toggle Zen Mode' })
