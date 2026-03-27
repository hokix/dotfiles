return {
  name = "go build",
  builder = function()
    return {
      cmd = { "go" },
      args = { "build" },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
