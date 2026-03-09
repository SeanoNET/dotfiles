-- Options — these override LazyVim defaults
-- See :help option-list for all options

local opt = vim.opt

opt.number = true               -- show line numbers
opt.relativenumber = true       -- relative line numbers (makes jumping easier: 5j = jump 5 lines down)
opt.scrolloff = 8               -- keep 8 lines visible above/below cursor
opt.sidescrolloff = 8
opt.clipboard = "unnamedplus"   -- use system clipboard (copy/paste works with Ctrl+C/V outside vim)
opt.mouse = "a"                 -- mouse works everywhere (click, scroll, select)
opt.undofile = true             -- persistent undo (survives closing the file)
opt.updatetime = 300            -- faster git gutter + completion updates
opt.expandtab = true            -- spaces instead of tabs
opt.tabstop = 4                 -- 4 spaces per tab
opt.shiftwidth = 4
