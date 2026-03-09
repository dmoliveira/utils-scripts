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
if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT or vim.env.SSH_TTY then
  vim.g.clipboard = "osc52"
end
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.o.updatetime = 300
vim.o.timeoutlen = 500
