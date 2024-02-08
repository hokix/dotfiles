-- Telescope fuzzy finding (all the things)
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
			"nvim-telescope/telescope-dap.nvim",
			"debugloop/telescope-undo.nvim",
		},
		-- optional = true,
		config = function()
			local telescope = require("telescope")

			local function flash(prompt_bufnr)
				require("flash").jump({
					pattern = "^",
					label = { after = { 0, 0 } },
					search = {
						mode = "search",
						exclude = {
							function(win)
								return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
							end,
						},
					},
					action = function(match)
						local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
						picker:set_selection(match.pos[1] - 1)
					end,
				})
			end
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
							["<C-h>"] = "which_key",
							["<C-q>"] = require("telescope.actions").smart_send_to_qflist
								+ require("telescope.actions").open_qflist,
							["<C-l>"] = require("telescope.actions").smart_send_to_loclist
								+ require("telescope.actions").open_loclist,
							["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
							["<C-s>"] = flash,
						},
						n = {
							["<C-h>"] = "which_key",
							["<C-q>"] = require("telescope.actions").smart_send_to_qflist
								+ require("telescope.actions").open_qflist,
							["<C-l>"] = require("telescope.actions").smart_send_to_loclist
								+ require("telescope.actions").open_loclist,
							["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
							s = flash,
						},
					},
				},
				extensions = {
					undo = {
						side_by_side = true,
						layout_strategy = "vertical",
						layout_config = {
							preview_height = 0.8,
						},
					},
				},
				pickers = {
					oldfiles = {
						only_cwd = true,
					}
				}
			})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "noice")
			pcall(require("telescope").load_extension, "dap")
			pcall(require("telescope").load_extension, "harpoon")
			pcall(require("telescope").load_extension, "undo")

			local map = require("helpers.keys").map
			map("n", "<leader>sr", require("telescope.builtin").oldfiles, "[S]earch [R]ecently Opened")
			map("n", "<leader>sb", require("telescope.builtin").buffers, "[S]earch Open [B]uffers")
			map("n", "<leader>sc", require("telescope.builtin").current_buffer_fuzzy_find, "[S]earch in [C]urrent Buffer")

			map("n", "<leader>sf", require("telescope.builtin").find_files, "[S]earch [F]iles")
			map("n", "<leader>sp", require("telescope.builtin").help_tags, "[S]earch Hel[p]")
			map("n", "<leader>sw", require("telescope.builtin").grep_string, "[S]earch Current [W]ord")
			map("n", "<leader>sg", require("telescope.builtin").live_grep, "[S]earch [G]rep")
			map("n", "<leader>sd", require("telescope.builtin").diagnostics, "[S]earch [D]iagnostics")
			map("n", "<leader>sh", require("telescope").extensions.harpoon.marks, "[S]earch [H]arpoon")
			map("n", "<leader>su", require("telescope").extensions.undo.undo, "[S]earch [U]ndo")

			map("n", "<C-p>", require("telescope.builtin").keymaps, "Search keyma[p]s")
		end,
	},
}
