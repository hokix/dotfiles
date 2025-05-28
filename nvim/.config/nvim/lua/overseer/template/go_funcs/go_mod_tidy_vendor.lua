return {
  name = "go mod tidy & vendor",
  builder = function()
    return {
      name = "go mod tidy & vendor",
      strategy = {
        "orchestrator",
        tasks = {
          "go mod tidy",
          "go mod vendor",
        },
      },
    }
  end,
  priority = 10,
  condition = {
    filetype = { "go" },
  },
}
