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
    },
  },
}
