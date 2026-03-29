-- LazyVim bootstrap
-- This loads the lazy.nvim plugin manager, then LazyVim handles the rest

-- Set leader key before anything else (Space)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim (auto-installs on first run)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim with LazyVim
require("lazy").setup({
  spec = {
    -- LazyVim base (gives you everything: LSP, completion, file tree, etc.)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Your custom plugin overrides
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  checker = { enabled = true },    -- auto-check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
