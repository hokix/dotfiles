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
      local wtf = require("wtf")
      if wtf ~= nil then
        table.insert(opts.sections.lualine_x, wtf.get_status())
      end
    end,
  },
}
