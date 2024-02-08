return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
			local noice = require("noice")
			noice.setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					progress = {
						enabled = false,
					}
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
			local map = require("helpers.keys").map
			map("n", "<leader>nc", function() noice.cmd("dismiss") end, "[N]oice [C]lear")
			-- map("n", "<leader>nd", function() noice.cmd("dismiss") end, "[N]oice [D]ismiss")
			map("n", "<leader>nl", function() noice.cmd("last") end, "[N]oice [L]ast")
			map("n", "<leader>nh", function() noice.cmd("history") end, "[N]oice [H]istory")
		end,
	},
}
