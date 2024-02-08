return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.sqlfmt.with({
						filetypes = { "sql", "mysql" },
					}),
					null_ls.builtins.formatting.prettierd,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						local lsp_map = require("helpers.keys").lsp_map
						-- maybe reuse set_lsp_keymaps in lsp.lua
						vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
							vim.lsp.buf.format()
						end, { desc = "Format current buffer with LSP" })

						lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "[F]ormat")
					end
				end,
			})
		end,
	},
}
