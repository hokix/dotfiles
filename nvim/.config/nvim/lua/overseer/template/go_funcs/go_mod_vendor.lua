return {
  name = "go mod vendor",
  builder = function()
    return {
      cmd = { "go" },
      args = { "mod", "vendor" },
      components = {
        "open_output_on_failure",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "go", "gomod", "gosum", "gowork" },
  },
}
