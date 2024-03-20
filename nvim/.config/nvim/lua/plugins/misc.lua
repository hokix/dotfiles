return {
  {
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    {
      "tpope/vim-abolish", -- Abbreviation,
      lazy = true,
      init = function()
        vim.g.abolish_no_mappings = true
      end,
      cmd = {
        "Abolish",
        "Subvert",
      },
      keys = {
        { "co", "<Plug>(abolish-coerce-word)", desc = "Abolish [co]erce" },
      },
    },
  },
  {
    "skywind3000/asyncrun.vim",
    lazy = true,
    cmd = { "AsyncRun" },
    init = function()
      vim.g.asyncrun_open = 10
    end,
  },
}
