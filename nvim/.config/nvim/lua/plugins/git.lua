-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 0,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
    },
    keys = { "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle [g]it [l]ens" },
  },
  {
    "akinsho/git-conflict.nvim",
    opts = {
      default_mappings = {
        ours = "co",
        theirs = "ct",
        none = "c0",
        both = "cb",
        next = "cn",
        prev = "cp",
      },
      cmd = {
        "GitConflictChooseOurs",
        "GitConflictChooseTheirs",
        "GitConflictChooseBoth",
        "GitConflictChooseNone",
        "GitConflictNextConflict",
        "GitConflictPrevConflict",
        "GitConflictListQf",
      },
      lazy = true,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
    },
    lazy = true,
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffViewOpen",
      "DiffViewClose",
    },
    lazy = true,
  },
}
