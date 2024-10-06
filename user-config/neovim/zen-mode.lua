require("zen-mode").setup({
  window = {
    backdrop = 1,
    width = 80,
    height = 1,
    options = {
      signcolumn = "no",
      number = false,
      colorcolumn = "",
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = true,
      showcmd = false,
      relativenumber = false,
      spell = true,
    },
    kitty = {
      enabled = false,
      font = "+4",
    },
  },
  on_open = function(win)
    require('cmp').setup.buffer { enabled = false }
  end,
  on_close = function()
    require('cmp').setup.buffer { enabled = true }
  end,
})
