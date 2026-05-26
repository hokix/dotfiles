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
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    optional = true,
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      latex = {
        enabled = false,
      },
      code = {
        highlight_border = false,
      },
    },
  },
  {
    "uhs-robert/sshfs.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      lead_prefix = "<leader>M",
      hooks = {
        on_exit = {
          auto_unmount = false,
        },
      },
      log = {
        enabled = false,
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>M", group = "mount", icon = "" },
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim",
    },
    optional = true,
  },
  {
    "HakonHarnes/img-clip.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      default = {
        dir_path = "~/Downloads",
        use_absolute_path = true,
        prompt_for_file_name = false,
      },
    },
    keys = {
      -- suggested keymap
      { "<leader>fP", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
