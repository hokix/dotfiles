-- Fetch and setup colorscheme if available, otherwise just return 'default'
-- This should prevent Neovim from complaining about missing colorschemes on first boot
local function get_if_available(name, opts)
	local lua_ok, colorscheme = pcall(require, name)
	if lua_ok then
		colorscheme.setup(opts)
		return name
	end

	local vim_ok, _ = pcall(vim.cmd.colorscheme, name)
	if vim_ok then
		return name
	end

	return "default"
end

-- Uncomment the colorscheme to use
local colorscheme = get_if_available('catppuccin', {
	flavour = "mocha",
	transparent_background = true,
	show_end_of_buffer = false,
	integrations = {
		aerial = true,
		neotree = true,
		illuminate = { enabled = true, lsp = true },
		which_key = true,
		notify = true,
		noice = true,
		fidget = true,
		treesitter = true,
		telescope = { enabled = true },
		mason = true,
		cmp = true,
		indent_blankline = { enabled = true },
		native_lsp = { enabled = true },
		dap = {
			enabled = true,
			enable_ui = true,
		},
		lsp_saga = true,
		lsp_trouble = true,
		neotest = true,
		harpoon = true,
	},
	custom_highlights = function(colors)
		return {
			-- highlight colors for rgflow
			RgFlowHead = { fg = colors.text },
			RgFlowHeadLine = { fg = colors.text },
			RgFlowInputBg = { fg = colors.text },
			RgFlowInputFlags = { fg = colors.text },
			RgFlowInputPattern = { fg = colors.teal },
			RgFlowInputPath = { fg = colors.text },
			RgFlowQfPattern = { fg = colors.pink },
		}
	end,
})
-- vim.cmd.colorscheme(colorscheme)
-- local colorscheme = get_if_available('everforest')

return colorscheme
