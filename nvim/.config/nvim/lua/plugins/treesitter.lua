return {

  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function()
      local install = require 'nvim-treesitter.install'
      vim.list_extend(install.compilers, {
        "~/.local/extra/bin/gcc",
        "~/.local/extra/bin/g++",
      })
    end
  },
}
