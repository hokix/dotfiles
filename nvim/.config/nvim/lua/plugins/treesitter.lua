return {

  {
    "nvim-treesitter/nvim-treesitter",
    commit = "ec034813775d7e2974c7551c8c34499a828963f8",
    optional = true,
    opts = function()
      local install = require("nvim-treesitter.install")
      install.compilers = install.compilers or {}
      vim.list_extend(install.compilers, {
        "~/.local/extra/bin/gcc",
        "~/.local/extra/bin/g++",
      })
    end,
  },
}
