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
          require("rgflow").open(nil, nil, nil, {
            custom_start = function(pattern, flags, path)
              print("Pattern:" .. pattern .. " Flags:" .. flags .. " Path:" .. path)
            end,
          })
        end,
        "[RG]flow",
      },
    },
  },
}
