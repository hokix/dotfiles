-- Fancier statuslin
--
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
		config = function()
			local colorscheme = require("helpers.colorscheme")
			local lualine_theme = colorscheme == "default" and "auto" or colorscheme
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = lualine_theme,
					-- component_separators = "|",
					-- section_separators = "",
				},
				extensions = {
					"aerial",
					"quickfix",
					"fugitive",
					"neo-tree",
					"nvim-dap-ui",
					"lazy",
					"mason",
					"trouble",
					"fzf",
					"oil",
					"trouble",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{ "branch" },
					},
					lualine_c = {
						{
							"diagnostics",
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
						{
							require("lsp-progress").progress,
						},
					},
					lualine_x = {
						{
							require("noice").api.status.command.get,
							cond = require("noice").api.status.command.has,
						},
						-- stylua: ignore
						{
							function()
								return "  " .. require("dap").status()
							end,
							cond = function()
								return package.loaded["dap"] and require("dap").status() ~= ""
							end,
						},
						{ require("lazy.status").updates, cond = require("lazy.status").has_updates },
						{
							require("interestingwords").lualine_get,
							cond = require("interestingwords").lualine_has,
							color = { fg = "#ff9e64" },
						},
						{ "diff" },
					},
					lualine_y = {
						{ "encoding", separator = " ", padding = { left = 1, right = 0 } },
						{ 'fileformat', separator = " ", padding = { left = 1, right = 0 }, icons_enabled = true },
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				tabline = {
					lualine_a = {'buffers'},
				}
			})
			-- listen lsp-progress event and refresh lualine
			vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				group = "lualine_augroup",
				pattern = "LspProgressStatusUpdated",
				callback = require("lualine").refresh,
			})
		end,
	},
	{
		"linrongbin16/lsp-progress.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lsp-progress").setup()
		end,
	},
}
