return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      scroll = { enabled = false },
      image = {
        enabled = true,
      },
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = false,
          },
          grep = {
            hidden = true,
            ignored = false,
          },
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
