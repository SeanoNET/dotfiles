-- Editor tweaks on top of LazyVim defaults
return {
  -- Auto-close brackets, quotes, etc.
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Git signs in the gutter (LazyVim includes gitsigns, just tweak it)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
      },
    },
  },

  -- Better fzf integration (LazyVim uses telescope by default, this is fine)
  -- Press Space f f to find files, Space / to grep, Space b b for buffers
}
