-- Plugin: retran/meow.yarn.nvim
-- Installed via store.nvim

return {
  {
    "retran/meow.yarn.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    lazy = true,
    config = function()
      require("meow.yarn").setup({})
    end,
    keys = {
      {
        "<leader>cyt",
        mode = { "n" },
        function()
          require("meow.yarn").open_tree("type_hierarchy", "supertypes")
        end,
        desc = "Yarn: Type Hierarchy (Super)",
      },
      {
        "<leader>cyT",
        mode = { "n" },
        function()
          require("meow.yarn").open_tree("type_hierarchy", "subtypes")
        end,
        desc = "Yarn: Type Hierarchy (Sub)",
      },
      {
        "<leader>cyc",
        mode = { "n" },
        function()
          require("meow.yarn").open_tree("call_hierarchy", "callers")
        end,
        desc = "Yarn: Call Hierarchy (Callers)",
      },
      {
        "<leader>cyC",
        mode = { "n" },
        function()
          require("meow.yarn").open_tree("call_hierarchy", "callees")
        end,
        desc = "Yarn: Call Hierarchy (Callees)",
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>cy", group = "meow.yarn" },
      },
    },
  },
}
