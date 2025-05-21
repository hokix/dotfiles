return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "alfaix/neotest-gtest",
    },
    opts = {
      adapters = {
        ["neotest-gtest"] = {
          debug_adapter = "codelldb",
        },
      },
    },
  },
  {
    "Civitasv/cmake-tools.nvim",
    optional = true,
    opts = {
      cmake_build_options = {
        "-j"
      },
      cmake_executor = {
        name = "quickfix",
        opts = {
          show = "only_on_error"
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    dependencies = {
      {
        "joechrisellis/lsp-format-modifications.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },
    },
    opts = {
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
          on_attach = function(client, bufnr)
            -- TODO: this format on save can not be disabled
            local lsp_format_modifications = require("lsp-format-modifications")
            lsp_format_modifications.attach(client, bufnr, { format_on_save = true })
          end,
        }
      },
    }
  }
}
