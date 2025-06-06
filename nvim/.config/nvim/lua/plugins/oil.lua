return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = {
        "permissions",
        "mtime",
        "icon",
      },
      -- view_options = {
      --   show_hidden = true,
      -- },

      float = {
        padding = 5,
      },
    },
    keys = { { "-", "<cmd>Oil --float<cr>", desc = "Open parent directory" } },
    lazy = false,
  },
}
