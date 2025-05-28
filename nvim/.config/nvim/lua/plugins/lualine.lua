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

      local mcphub_lualine = require("mcphub.extensions.lualine")
      if mcphub_lualine ~= nil then
        table.insert(opts.sections.lualine_x, { mcphub_lualine })
      end
    end,
  },
}
