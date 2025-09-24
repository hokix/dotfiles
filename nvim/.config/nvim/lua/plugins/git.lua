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
