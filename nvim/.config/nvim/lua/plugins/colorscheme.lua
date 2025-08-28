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
        -- "TroubleNormal",
        -- "TroubleNormalNC",
        -- "EdgyNormal",
        "RgFlowHead",
        "RgFlowHeadLine",
        "RgFlowInputBg",
        "RgFlowInputFlags",
        "RgFlowInputPattern",
        "RgFlowInputPath",
        "RgFlowQfPattern",
      },
    },
  },
}
