return {
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
  {
    "Civitasv/cmake-tools.nvim",
    optional = true,
    opts = {
      cmake_build_options = {
        "-j"
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        cpp = { "clang-format" },
      }
    },
  },
}
