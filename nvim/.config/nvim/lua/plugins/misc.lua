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
    "skywind3000/asyncrun.vim",
    lazy = true,
    cmd = { "AsyncRun" },
    init = function()
      vim.g.asyncrun_open = 10
    end,
  },
  {
    "hat0uma/csvview.nvim",
    lazy = true,
    cmd = { "CsvViewToggle" },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "Saghen/blink.cmp",
      "folke/snacks.nvim",
    },
    lazy = true,
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/Documents/obsidian/notes",
        },
      },
      templates = {
        folder = "模板",
      },
      ui = {
        -- use render-markdown ui
        enable = false,
      },
    },
    cmd = {
      "ObsidianNew",
      "ObsidianNewFromTemplate",
      "ObsidianWorkspace",
    },
  },
  -- mason workaround
  { "mason-org/mason.nvim", version = "1.11.0" },
  { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
}
