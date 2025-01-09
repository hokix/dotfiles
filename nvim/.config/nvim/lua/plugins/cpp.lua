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
  }
}
