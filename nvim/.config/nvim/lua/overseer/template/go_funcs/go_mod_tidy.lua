return {
  name = "go mod tidy",
  builder = function()
    return {
      cmd = { "go" },
      args = { "mod", "tidy" },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
