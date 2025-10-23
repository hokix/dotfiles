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
      disabled_filetypes = {
        maven = true,
      },
    },
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
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>M", group = "mount", icon = "" },
      },
    },
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
    "saxon1964/neovim-tips",
    version = "*", -- Only update on tagged releases
    dependencies = {
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      -- OPTIONAL: Daily tip mode (default: 1)
      -- 0 = off, 1 = once per day, 2 = every startup
      daily_tip = 1,
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    dependencies = {
      "folke/snacks.nvim",
      "saghen/blink.cmp",
      "MeanderingProgrammer/render-markdown.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    version = "*", -- recommended, use latest release instead of latest commit
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/obsidian/notes/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/obsidian/notes/*.md",
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/obsidian/notes/*/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/obsidian/notes/*/*.md",
    },
    cmd = { "Obsidian" },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/Documents/obsidian/notes",
        },
      },

      -- see below for full list of options 👇
    },
  },
}
