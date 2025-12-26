-- Global variables used in Neovim configuration
globals = {
  "vim",
  "LazyVim",
  "Snacks",
}

-- Read-only globals
read_globals = {
  "vim",
  "LazyVim",
  "Snacks",
}

-- Ignore common Neovim patterns and warnings
ignore = {
  "212", -- Unused argument (common in Neovim callbacks)
  "631", -- Line too long
}

-- Allow overwriting unpack (Lua 5.1 compatibility)
std = "max"

-- File-specific settings
files["**/lazy*.lua"] = {
  globals = { "LazyVim" }
}

files["**/example.lua"] = {
  ignore = { "unreachable" }
}
