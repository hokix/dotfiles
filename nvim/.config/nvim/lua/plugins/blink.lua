return {
  {
    "saghen/blink.cmp",
    -- dependencies = {
    --   "Kaiser-Yang/blink-cmp-avante",
    -- },
    optional = true,
    opts = {
      keymap = {
        preset = "enter",
        ["<C-space>"] = {},
      },
      completion = {
        menu = { border = "rounded" },
        documentation = { window = { border = "rounded" } },
      },
      signature = { window = { border = "rounded" } },
      fuzzy = {
        prebuilt_binaries = {
          -- download = false,
          -- ignore_version_mismatch = true,
        },
      },
      -- sources = {
      --   -- Add 'avante' to the list
      --   default = { "avante", "lsp", "path", "snippets", "buffer" },
      --   providers = {
      --     avante = {
      --       module = "blink-cmp-avante",
      --       name = "Avante",
      --       opts = {
      --         -- options for blink-cmp-avante
      --       },
      --     },
      --   },
      -- },
    },
  },
}
