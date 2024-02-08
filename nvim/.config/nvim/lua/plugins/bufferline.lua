-- See current buffers at the top of the editor
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					-- mode = "buffers",
					themable = true,
					diagnostics = "nvim_lsp",
					highlights = require("catppuccin.groups.integrations.bufferline").get(),
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neo-tree",
							highlight = "Directory",
							text_align = "left",
						},
					},
				},
			})
		end,
	},
}
