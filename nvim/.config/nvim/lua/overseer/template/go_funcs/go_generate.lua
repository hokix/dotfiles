return {
  name = "go generate",
  builder = function()
    return {
      cmd = { "go" },
      args = { "generate", vim.fn.expand("%:p") },
    }
  end,
  priority = 30,
  condition = {
    filetype = { "go" },
  },
}
