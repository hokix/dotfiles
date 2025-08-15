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
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
      restriction_mode = "hint",
    },
  },
  -- mason workaround
  { "mason-org/mason.nvim", version = "1.11.0" },
  { "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
  {
    "uhs-robert/sshfs.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      lead_prefix = "<leader>M",
      log = {
        enabled = false,
      },
    },
  },
}
