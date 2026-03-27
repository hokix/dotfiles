return {
  name = "go generate",
  builder = function()
    return {
      cmd = { "go" },
      args = { "generate", vim.fn.expand("%:p") },
    }
  end,
  condition = {
    filetype = { "go" },
  },
}
