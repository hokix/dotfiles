return {
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.register(
				{
					["<leader>"] = {
						f = { name = "File" },
						d = { name = "Delete / Close" },
						q = { name = "Quit" },
						s = { name = "Search" },
						l = { name = "LSP" },
						u = { name = "UI" },
						b = { name = "Buffer" },
						g = { name = "Git" },
						t = { name = "Test / Tag" },
						x = { name = "Trouble" },
					}
				}
			)
		end
	}
}
