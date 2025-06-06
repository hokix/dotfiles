return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.bg_statusline = colors.none -- To check if its working try something like "#ff00ff" instead of colors.none
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
            colorscheme = "catppuccin",
            -- colorscheme = "tokyonight",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      -- show_end_of_buffer = false,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        harpoon = true,
        headlines = true,
        illuminate = {
          enabled = true,
        },
        indent_blankline = { enabled = true },
        leap = true,
        lsp_saga = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = true,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = {
          enabled = true,
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
                blink_cmp = true,
      },
      custom_highlights = function(colors)
        return {
          -- highlight colors for rgflow
          RgFlowHead = { fg = colors.text },
          RgFlowHeadLine = { fg = colors.text },
          RgFlowInputBg = { fg = colors.text },
          RgFlowInputFlags = { fg = colors.text },
          RgFlowInputPattern = { fg = colors.teal },
          RgFlowInputPath = { fg = colors.text },
          RgFlowQfPattern = { fg = colors.pink },
        }
      end,
    },
  },
}
