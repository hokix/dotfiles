return {
  {
    "bennypowers/nvim-regexplainer",
    opts = {
      mode = "narrative",
      auto = false,
      filetypes = { "go", "cpp", "python", "lua", "php", "html", "js" },
      popup = {
        position = 4,
        border = {
          style = "rounded",
        },
      },
    },
    keys = {
      { "<leader>re", "<cmd>RegexplainerToggle<cr>", "[R]eg[e]xplainerToggle" },
    },
    cmd = {
      "RegexplainerToggle",
      "RegexplainerShowSplit",
      "RegexplainerShowPopup",
      "RegexplainerHide",
    },
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },
}
