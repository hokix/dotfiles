-- Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
			-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "vim", "vimdoc", "markdown", "markdown_inline", "regex", "bash", "php" },

				highlight = { enable = true },
				indent = { enable = true, disable = { "python" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = false,
						node_incremental = "<c-i>",
						scope_incremental = false,
						node_decremental = "<c-n>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]]"] = "@class.outer",
							["]l"] = "@loop.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]["] = "@class.outer",
							["]L"] = "@loop.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[["] = "@class.outer",
							["[l"] = "@loop.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[]"] = "@class.outer",
							["[L"] = "@loop.outer",
						},
					},
				},
			})
		end,
	},
}
