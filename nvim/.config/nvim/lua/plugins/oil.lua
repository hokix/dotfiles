return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = {
        -- "permissions",
        "mtime",
        "icon",
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
    lazy = true,
  },
}
