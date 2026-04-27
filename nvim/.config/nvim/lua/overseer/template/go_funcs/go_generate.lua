return {
  name = "go generate",
  builder = function()
    return {
      cmd = { "go" },
      args = { "generate", vim.fn.expand("%:p") },
      -- use_terminal = false preserves raw \t so expand_wire_lines can detect
      -- continuation lines by their leading tab character
      strategy = { "jobstart", use_terminal = false },
      components = {
        "on_wire_output_quickfix",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "go", "gomod", "gosum", "gowork" },
  },
}
