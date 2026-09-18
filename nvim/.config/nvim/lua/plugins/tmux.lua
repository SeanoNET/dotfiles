-- Seamless navigation between tmux panes and neovim splits
-- Use Ctrl+h/j/k/l to move in any direction, across both tmux and neovim
return {
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "Navigate left (tmux/nvim)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "Navigate down (tmux/nvim)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "Navigate up (tmux/nvim)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right (tmux/nvim)" },
    },
  },

}
