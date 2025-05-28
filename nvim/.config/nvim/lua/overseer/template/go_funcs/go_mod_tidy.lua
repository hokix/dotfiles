return {
  name = "go mod tidy",
  builder = function()
    return {
      cmd = { "go" },
      args = { "mod", "tidy" },
    }
  end,
  priority = 100,
  condition = {
    filetype = { "go" },
  },
}
