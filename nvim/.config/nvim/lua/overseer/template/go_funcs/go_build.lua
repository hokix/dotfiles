return {
  name = "go build",
  builder = function()
    local args = { "build" }
    if vim.fn.isdirectory(vim.fn.getcwd() .. "/vendor") == 1 then
      table.insert(args, "-mod=vendor")
    end
    return {
      cmd = { "go" },
      args = args,
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
