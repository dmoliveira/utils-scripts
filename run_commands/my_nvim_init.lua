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
  -- Navigation & Editing
  { "windwp/nvim-autopairs", event = "InsertEnter" },  -- Auto-close brackets, quotes, etc.
  { "numToStr/Comment.nvim", config = true },          -- Toggle comments easily (gcc, gc)
  { "folke/which-key.nvim", config = true },           -- Displays available keybindings
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Show code indentation guides
  { "tpope/vim-surround" },                            -- Surround text with quotes, brackets
  -- Status line
  { "nvim-lualine/lualine.nvim" },
  -- Colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "navarasu/onedark.nvim" },
  { "gruvbox-community/gruvbox" },
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
  -- Developer Experience
  { "nvimtools/none-ls.nvim" },                        -- Successor of null-ls (LSP-style linters/formatters)
  { "rcarriga/nvim-notify" },                          -- Better notifications UI
  { "akinsho/toggleterm.nvim", config = true },        -- Integrated terminal, great for running Python scripts
  { "stevearc/overseer.nvim" },                        -- Manage background jobs or experiment runs
  { "lewis6991/impatient.nvim" },                      -- Speeds up startup time (cache Lua modules)
  -- Python dev tools
  { "mfussenegger/nvim-dap" },           -- Debugging
  { "mfussenegger/nvim-lint" },          -- Linting
  { "stevearc/conform.nvim" },           -- Autoformat
  { "jose-elias-alvarez/null-ls.nvim" },               -- Integrate black, flake8, isort
  { "mfussenegger/nvim-dap-python" },                  -- Debug Python
  { "linux-cultist/venv-selector.nvim", config = true }, -- Quickly switch between Python venvs
  { "Vigemus/iron.nvim" },                             -- REPL integration (run code interactively, like Jupyter)

  -- AI/ML helpers
  { "github/copilot.vim" },              -- GitHub Copilot
  { "jackMort/ChatGPT.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" } },
  -- Visual Polish
  { "nvimdev/dashboard-nvim" },                        -- Custom start screen
})

require("nvim-tree").setup()

-- General editing settings
vim.o.number = true
vim.o.relativenumber = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.updatetime = 300
vim.o.timeoutlen = 500

-- Handy Key Mappings VIM
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>c", ":bd<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>o", ":NvimTreeFocus<CR>",  { desc = "Focus file explorer" })
vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { desc = "Reveal current file in tree" })

-- Theme
require("catppuccin").setup({ flavour = mocha })
vim.cmd.colorscheme("catppuccin")

-- Statusline
require("lualine").setup({
  options = { theme = "catppuccin" },
})
