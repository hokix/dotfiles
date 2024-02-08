return {
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function ()
			require("oil").setup({
				columns = {
					-- "permissions",
					"mtime",
					"icon",
				},
				view_options = {
					show_hidden = true,
				}
			})
			local map = require("helpers.keys").map
			map("n", "-", "<CMD>Oil<CR>", "Open parent directory")
		end
	},
}
