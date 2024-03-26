return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = true,
      },
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
      ---@type lspconfig.options
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        border = "rounded",
        code_action = " ",
      },
      lightbulb = {
        enable = false,
      },
      code_action = {
        show_server_name = true,
        extend_gitsigns = true,
      },
    },
    keys = {
      { "<leader>tm", "<cmd>Lspsaga term_toggle<cr>", desc = "[T]oggle Ter[m]inal", mode = { "n", "t" } },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
}
