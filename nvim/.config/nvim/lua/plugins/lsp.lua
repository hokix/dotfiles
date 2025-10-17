return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    ---@class PluginLspOpts
    opts = {
      virtual_lines = {
        current_line = true,
      },
    },
  },
  {
    "oribarilan/lensline.nvim",
    tag = "2.0.0", -- or: branch = 'release/1.x' for latest non-breaking updates
    event = "LspAttach",
    config = function()
      require("lensline").setup()
    end,
    lazy = true,
  },
  {
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
  },
  {
    "zerochae/endpoint.nvim",
    dependencies = {
      -- Choose one or more pickers (all optional):
      "folke/snacks.nvim", -- For snacks picker
      -- vim.ui.select picker works without dependencies
    },
    cmd = { "Endpoint" },
    opt = {
      cache = {
        mode = "persistent",
      },
      picker = {
        type = "snacks",
      },
    },
    config = function(_, opts)
      require("endpoint").setup(opts)
    end,
    lazy = true,
  },
}
