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
            components = {
              "open_output_on_failure",
              "default",
            },
          },
          {
            cmd = { "go" },
            args = { "mod", "vendor" },
            components = {
              "open_output_on_failure",
              "default",
            },
          },
        },
      },
    }
  end,
  condition = {
    filetype = { "go", "gomod", "gosum", "gowork" },
  },
}
