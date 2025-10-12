-- init.lua
-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- File Explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- Status line
  { "nvim-lualine/lualine.nvim" },
  -- Colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- Syntax & Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- Telescope fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  -- Git
  { "lewis6991/gitsigns.nvim" },
  -- LSP and completions
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  -- Python dev tools
  { "mfussenegger/nvim-dap" },           -- Debugging
  { "mfussenegger/nvim-lint" },          -- Linting
  { "stevearc/conform.nvim" },           -- Autoformat
  -- AI/ML helpers
  { "github/copilot.vim" },              -- GitHub Copilot
  { "jackMort/ChatGPT.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" } },
})

-- Handy Key Mappings VIM
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

-- Theme
vim.cmd.colorscheme("catppuccin")

-- Statusline
require("lualine").setup({
  options = { theme = "catppuccin" },
})
