return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    dependencies = {
        "joechrisellis/lsp-format-modifications.nvim",
        init = function()
            require("lazyvim.util").lsp.on_attach(function(client, bufnr)
                local augroup_id = vim.api.nvim_create_augroup(
                    "FormatModificationsDocumentFormattingGroup",
                    { clear = false }
                )
                vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })

                vim.api.nvim_create_autocmd(
                    { "BufWritePre" },
                    {
                    group = augroup_id,
                    buffer = bufnr,
                    callback = function()
                        local lsp_format_modifications = require"lsp-format-modifications"
                        lsp_format_modifications.format_modifications(client, bufnr)
                    end,
                    }
                )
            end)
        end,
    },
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
}
