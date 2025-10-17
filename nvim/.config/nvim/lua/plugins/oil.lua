local detail = false

return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      -- columns = {
      --   "permissions",
      --   "mtime",
      --   "icon",
      -- },
      -- view_options = {
      --   show_hidden = true,
      -- },

      float = {
        padding = 5,
      },
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
      },
    },
    keys = { { "-", "<cmd>Oil --float<cr>", desc = "Open parent directory" } },
    lazy = false,
  },
  {
    "benomahony/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
  },
  {
    "JezerM/oil-lsp-diagnostics.nvim",
    dependencies = { "stevearc/oil.nvim" },
  },
}
