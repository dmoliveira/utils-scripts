local source = debug.getinfo(1, "S").source
if source:sub(1, 1) == "@" then
  local init_dir = vim.fn.fnamemodify(source:sub(2), ":p:h")
  local local_lua_dir = init_dir .. "/nvim/lua"
  if vim.fn.isdirectory(local_lua_dir) == 1 then
    package.path = local_lua_dir .. "/?.lua;" .. local_lua_dir .. "/?/init.lua;" .. package.path
  end
end

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

require("lazy").setup(require("utils_scripts.plugins"))

require("utils_scripts.options")
require("utils_scripts.lsp")
require("utils_scripts.keymaps")
require("utils_scripts.ui")
