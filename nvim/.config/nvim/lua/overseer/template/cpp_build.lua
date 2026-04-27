return {
  name = "g++ build",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "g++" },
      args = { file },
      components = {
        "open_output_on_failure",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
