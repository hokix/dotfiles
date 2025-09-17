return {
  {
    {
      "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
      lazy = true,
      event = "VeryLazy",
    },
    {
      "tpope/vim-abolish", -- Abbreviation,
      lazy = true,
      init = function()
        vim.g.abolish_no_mappings = true
      end,
      cmd = {
        "Abolish",
        "Subvert",
      },
      keys = {
        { "co", "<Plug>(abolish-coerce-word)", desc = "Abolish [co]erce" },
      },
    },
  },
  {
    "hat0uma/csvview.nvim",
    lazy = true,
    cmd = { "CsvViewToggle" },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      disable_mouse = false,
      restriction_mode = "hint",
    },
  },
  -- mason workaround
  { "mason-org/mason.nvim", branch = "v1.x" },
  { "mason-org/mason-lspconfig.nvim", branch = "v1.x" },
  -- bufferline/catppuccin workaround
  {
    "akinsho/bufferline.nvim",
    optional = true,
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
  {
    "uhs-robert/sshfs.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      lead_prefix = "<leader>M",
      mounts = {
        unmount_on_exit = false,
      },
      log = {
        enabled = false,
      },
    },
  },
  {
    "alex-popov-tech/store.nvim",
    dependencies = { "OXY2DEV/markview.nvim" },
    cmd = "Store",
    lazy = true,
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
    lazy = true,
  },
}
