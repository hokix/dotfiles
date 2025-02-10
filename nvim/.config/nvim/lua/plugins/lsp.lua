return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
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
