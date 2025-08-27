local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font_with_fallback({
	{
		family = "CaskaydiaMono Nerd Font",
		weight = "Regular",
	},
})
config.font_size = 13.5
config.color_scheme = "Catppuccin Mocha"

return config
