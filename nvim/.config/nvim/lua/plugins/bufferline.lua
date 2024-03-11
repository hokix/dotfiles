-- See current buffers at the top of the editor
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local opts = {
				options = {
					-- mode = "buffers",
					themable = true,
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neo-tree",
							highlight = "Directory",
							text_align = "left",
						},
					},
				},
			}
			local colorscheme = require("helpers.colorscheme")
			if colorscheme == "catppuccin" then
				opts.options.highlights = require("catppuccin.groups.integrations.bufferline").get()
			end
			require("bufferline").setup(opts)
		end,
		enabled = false,
	},
}
