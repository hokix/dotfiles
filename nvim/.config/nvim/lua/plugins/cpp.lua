return {
  {
    "stevearc/conform.nvim",
    optional = true,
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "clang-format" })
        end
      end,
    },
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "alfaix/neotest-gtest",
    },
    opts = {
      adapters = {
        ["neotest-gtest"] = {
          debug_adapter = "codelldb",
        },
      },
    },
  },
}
