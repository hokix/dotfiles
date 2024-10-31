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
}
