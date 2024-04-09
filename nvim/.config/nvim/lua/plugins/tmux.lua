return {
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true, -- defaults to false
    },
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", desc = "vim tmux left" },
      { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", desc = "vim tmux down" },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", desc = "vim tmux up" },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "vim tmux right" },
      { "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", desc = "vim tmux last active" },
    },
    lazy = true,
  },
}
