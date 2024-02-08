return {
	"bennypowers/nvim-regexplainer",
	config = function()
		require("regexplainer").setup({
			mode = "narrative",
			auto = true,
			filetypes = { "go", "cpp", "python", "lua", "php", "html", "js" },
			popup = {
				position = "4",
				border = {
					style = "rounded",
					-- padding = { 1, 2 },
				},
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"MunifTanjim/nui.nvim",
	},
}
