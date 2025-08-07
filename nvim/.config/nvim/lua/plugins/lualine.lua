return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local overseer = require("overseer")
      if overseer ~= nil then
        table.insert(opts.sections.lualine_x, "overseer")
      end
    end,
  },
}
