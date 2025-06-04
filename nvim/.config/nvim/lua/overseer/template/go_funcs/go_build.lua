return {
  name = "go build",
  builder = function()
    return {
      cmd = { "go" },
      args = { "build" },
    }
  end,
  priority = 20,
  condition = {
    filetype = { "go" },
  },
}
