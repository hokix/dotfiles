return {
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {
      disable_when_zoomed = true, -- defaults to false
    },
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", "vim tmux left" },
      { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", "vim tmux down" },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", "vim tmux up" },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", "vim tmux right" },
      { "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", "vim tmux last active" },
    },
    lazy = true,
  },
}
