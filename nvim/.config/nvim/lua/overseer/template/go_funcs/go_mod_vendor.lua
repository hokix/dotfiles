return {
  name = "go mod vendor",
  builder = function()
    return {
      cmd = { "go" },
      args = { "mod", "vendor" },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
