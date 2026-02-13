return {
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "windwp/nvim-autopairs", event = "InsertEnter" },
  { "numToStr/Comment.nvim", config = true },
  { "folke/which-key.nvim", config = true },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "tpope/vim-surround" },
  { "nvim-lualine/lualine.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "navarasu/onedark.nvim" },
  { "gruvbox-community/gruvbox" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "lewis6991/gitsigns.nvim" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "nvimtools/none-ls.nvim" },
  { "rcarriga/nvim-notify" },
  { "akinsho/toggleterm.nvim", config = true },
  { "stevearc/overseer.nvim" },
  { "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-lint" },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_format" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        json = { "jq" },
      },
    },
  },
  { "mfussenegger/nvim-dap-python" },
  { "linux-cultist/venv-selector.nvim", config = true },
  { "Vigemus/iron.nvim" },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({ dap = { justMyCode = false } }),
        },
      })
    end,
  },
  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-completion" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" },
  },
  { "nvimdev/dashboard-nvim" },
}
