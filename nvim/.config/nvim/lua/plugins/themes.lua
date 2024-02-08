-- Themes
return {
	"typicode/bg.nvim",

	"ellisonleao/gruvbox.nvim",

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			local colorscheme = require("helpers.colorscheme")
			if colorscheme == "catppuccin" then
				require("catppuccin").setup({
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
				vim.cmd.colorscheme("catppuccin")
			end
		end,
	},

	{
		"rose-pine/nvim",
		name = "rose-pine",
	},

	"sainnhe/everforest",

	"savq/melange-nvim",
}
