require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "bashls", "jsonls" },
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
  pyright = {},
  bashls = {},
  jsonls = {},
}

for server, opts in pairs(servers) do
  opts.capabilities = lsp_capabilities
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
