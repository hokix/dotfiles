return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
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
      { "<leader>tm", "<cmd>Lspsaga term_toggle<cr>", "[T]oggle Ter[m]inal", mode = { "n", "t" } },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
}
