require("nvim-tree").setup()

require("catppuccin").setup({ flavour = "mocha" })
vim.cmd.colorscheme("catppuccin")

require("lualine").setup({
  options = { theme = "catppuccin" },
})
