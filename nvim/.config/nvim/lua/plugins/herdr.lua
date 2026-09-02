return {
  {
    "aimdevlee/herdr-nvim-nav",
    -- dependencies = { "christoomey/vim-tmux-navigator" }, -- omit if with_tmux = false
    config = function()
      require("herdr-nvim-nav").setup({
        keymaps = { -- lhs list per direction; {} disables a direction
          left = { "<C-h>", "<C-Left>" },
          down = { "<C-j>", "<C-Down>" },
          up = { "<C-k>", "<C-Up>" },
          right = { "<C-l>", "<C-Right>" },
        },
      })
    end,
  },
}
