-- Global variables used in Neovim configuration
globals = {
  "vim",
  "LazyVim",
}

-- Read-only globals
read_globals = {
  "vim",
  "LazyVim",
}

-- Ignore common Neovim patterns
ignore = {
  "212", -- Unused argument (common in Neovim callbacks)
}

-- File-specific settings
files["**/lazy*.lua"] = {
  globals = { "LazyVim" }
}
