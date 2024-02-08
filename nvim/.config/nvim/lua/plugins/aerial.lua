return {
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				layout = {
					max_width = {60, 0.3},
				},
				-- on_attach = function(bufnr)
				-- 	-- Jump forwards/backwards with '{' and '}'
				-- 	vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				-- 	vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				-- end,
				-- autojump = true,
			})
			vim.keymap.set("n", "<leader>tt", "<cmd>AerialToggle<CR>")
		end,
	},
}
