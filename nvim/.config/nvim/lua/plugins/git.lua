-- Git related plugins
return {
	{
		"lewis6991/gitsigns.nvim",
		config = function ()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 0,
					ignore_whitespace = true,
				},
				current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> - <summary>',
			})
			local map = require("helpers.keys").map
			map("n", "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle git lens");
		end
	},
	{
		"akinsho/git-conflict.nvim",
		-- commit = "2957f74",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					ours = "co",
					theirs = "ct",
					none = "c0",
					both = "cb",
					next = "cn",
					prev = "cp",
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		config = function ()
			-- local map = require("helpers.keys").map
			-- map("n", "<leader>ga", "<cmd>Git add %<cr>", "Stage the current file")
			-- map("n", "<leader>gb", "<cmd>Git blame<cr>", "Show the blame")
		end
	},
	{
		"sindrets/diffview.nvim",
	}
}
