return {
  {
    "stevearc/overseer.nvim",
    optional = true,
    init = function()
      require("overseer").load_template("user")
    end,
  },
}
