return {
  {
    "mangelozzi/rgflow.nvim",
    opts = {
      cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",
      default_trigger_mappings = false,
      default_ui_mappings = true,
      default_quickfix_mappings = true,
      ui_top_line_char = "━",
    },
    lazy = true,
    keys = {
      {
        "<leader>rg",
        function()
          require("rgflow").open()
        end,
        desc = "[RG]flow",
      },
    },
  },
}
