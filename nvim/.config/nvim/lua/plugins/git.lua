-- Git related plugins
return {
  {
    "lewis6991/gitsigns.nvim",
    optional = true,
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 200,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "  <author>, <author_time:%Y-%m-%d> - <summary>",
    },
    lazy = true,
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
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
    opts = {
      enhanced_diff_hl = true,
    },
  },
}
