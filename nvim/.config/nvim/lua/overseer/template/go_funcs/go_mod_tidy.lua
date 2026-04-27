return {
  name = "go mod tidy",
  builder = function()
    return {
      cmd = { "go" },
      args = { "mod", "tidy" },
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
