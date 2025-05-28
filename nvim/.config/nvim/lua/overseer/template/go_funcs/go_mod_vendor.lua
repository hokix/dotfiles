return {
  name = "go mod vendor",
  builder = function()
    return {
      cmd = { "go" },
      args = { "mod", "vendor" },
    }
  end,
  priority = 101,
  condition = {
    filetype = { "go" },
  },
}
