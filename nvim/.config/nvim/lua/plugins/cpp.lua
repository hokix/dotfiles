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
        "-j",
      },
      cmake_executor = {
        name = "quickfix",
        opts = {
          show = "only_on_error",
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
            local augroup_id =
              vim.api.nvim_create_augroup("FormatModificationsDocumentFormattingGroup", { clear = false })
            vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })

            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
              group = augroup_id,
              buffer = bufnr,
              callback = function()
                local lsp_format_modifications = require("lsp-format-modifications")
                lsp_format_modifications.format_modifications(client, bufnr)
              end,
            })
          end,
        },
      },
    },
  },
}
