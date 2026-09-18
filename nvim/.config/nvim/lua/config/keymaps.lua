-- Keymaps — custom shortcuts on top of LazyVim defaults
--
-- LazyVim already gives you:
--   Space f f  = find files
--   Space f r  = recent files
--   Space /    = search in files (grep)
--   Space b b  = switch buffer
--   Space e    = file explorer (toggle sidebar)
--   Space l    = Lazy plugin manager
--   Space c a  = code actions
--   g d        = go to definition
--   g r        = go to references
--   K          = hover docs
--   [ d / ] d  = previous/next diagnostic
--   Space q q  = quit all
--
-- Full list: press Space and wait (which-key popup shows all options)

local map = vim.keymap.set

-- Quick save with Space w (just saves, no quit)
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- Close current buffer with Space x
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Split navigation handled by vim-tmux-navigator (Ctrl+h/j/k/l)

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
