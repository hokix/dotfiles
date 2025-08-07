return {
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {
      colors = {
        "#8839ef",
        "#d20f39",
        "#e64553",
        "#fe640b",
        "#df8e1d",
        "#40a02b",
        "#179299",
        "#04a5e5",
        "#209fb5",
        "#1e66f5",
        "#7287fd",
        "#4c4f69",
        "#5c5f77",
        "#6c6f85",
      },
      navigation = false,
      search_count = true,
      color_key = "<leader>m",
      cancel_color_key = "<leader>M",
    },
    lazy = true,
    keys = {
      { "<leader>m", desc = "InterestingWord Toggle Color" },
      { "<leader>M", desc = "InterestingWord Uncolor " },
    },
  },
}
