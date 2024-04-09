return {
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {
      colors = {
        "#f38ba8",
        "#eba0ac",
        "#fab387",
        "#f5e0dc",
        "#a6e3a1",
        "#89dceb",
        "#89b4fa",
        "#b4befe",
        "#cba6f7",
      },
      navigation = true,
      search_count = true,
      color_key = "<leader>m",
      cancel_color_key = "<leader>M",
    },
    -- event = "VeryLazy",
    lazy = true,
    keys = {
      { "<leader>m", desc = "InterestingWord Toggle Color" },
      { "<leader>M", desc = "InterestingWord Uncolor " },
    },
  },
}
