return {
  {
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    {
      "tpope/vim-abolish", -- Abbreviation,
      lazy = true,
      cmd = {
        "Abolish",
        "Subvert",
      },
    },
  },
  {
    "skywind3000/asyncrun.vim",
    lazy = true,
    cmd = { "AsyncRun" },
  },
}
