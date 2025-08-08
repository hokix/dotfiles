return {
  name = "go mod tidy & vendor",
  builder = function()
    return {
      name = "go mod tidy & vendor",
      strategy = {
        "orchestrator",
        tasks = {
          {
            cmd = { "go" },
            args = { "mod", "tidy" },
          },
          {
            cmd = { "go" },
            args = { "mod", "vendor" },
          },
        },
      },
    }
  end,
  priority = 10,
  condition = {
    filetype = { "go" },
  },
}
