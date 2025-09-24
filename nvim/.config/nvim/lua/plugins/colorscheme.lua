return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    optional = true,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.bg_statusline = colors.none -- To check if its working try something like "#ff00ff" instead of colors.none
      end,
      on_highlights = function(hl, colors)
        hl.TabLineFill = {
          bg = colors.none,
        }
      end,
    },
  },
  {
    "catppuccin/nvim",
    optional = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      auto_integrations = true,
      float = {
        transparent = true,
      },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "RenderMarkdownCode",
      },
    },
  },
  {
    {
      "Mr-LLLLL/interestingwords.nvim",
      opts = {
        colors = {
          "#f38ba8",
          "#eba0ac",
          "#fab387",
          "#f5e0dc",
          "#a6e3a1",
          "#89dceb",
          "#89b4fa",
          "#b4befe",
          "#cba6f7",
          "#bac2de",
          "#9399b2",
        },
        navigation = false,
        search_count = true,
        color_key = "<leader>m",
        cancel_color_key = "<leader>Mc",
      },
      lazy = true,
      keys = {
        { "<leader>m", desc = "InterestingWord Toggle Color" },
        { "<leader>Mc", desc = "InterestingWord Uncolor " },
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      lazy_load = true,
    },
    event = "VeryLazy",
  },
}
