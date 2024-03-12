-- Miscelaneous fun stuff
return {
	-- Comment with haste
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	-- Move stuff with <M-j> and <M-k> in both normal and visual mode
	{
		"echasnovski/mini.move",
		config = function()
			require("mini.move").setup()
		end,
	},
	-- Better buffer closing actions. Available via the buffers helper.
	{
		"kazhala/close-buffers.nvim",
		opts = {
			preserve_window_layout = { "this", "nameless" },
		},
	},
	{
		"famiu/bufdelete.nvim",
		config = function()
			local map = require("helpers.keys").map
			map("n", "<leader>bC", "<cmd>Bdelete<cr>", "[B]uffer [C]lose(keep layout)")
		end,
	},
	"tpope/vim-sleuth",    -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround",  -- Surround stuff with the ys-, cs-, ds- commands
	"tpope/vim-characterize", -- Character representation with ga
	"tpope/vim-abolish",   -- Abbreviation,
	"tpope/vim-repeat",    -- Repeat with .
	"tpope/vim-obsession", -- Make sessions
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
	},
	"yssl/QFEnter", -- open qf/loc split/vertical split/tab
	{
		"skywind3000/asyncrun.vim",
		config = function()
			vim.g.asyncrun_open = 10
		end,
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("harpoon").setup({
				menu = {
					width = vim.api.nvim_win_get_width(0) - 50,
				},
			})
		end,
		keys = {
			{
				"<leader>hm",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Harpoon mark",
			},
			{
				"<leader>ht",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Harpoon toggle quick menu",
			},
			{
				"<leader>hn",
				function()
					require("harpoon.ui").nav_next()
				end,
				desc = "Harpoon goto next",
			},
			{
				"<leader>hp",
				function()
					require("harpoon.ui").nav_prev()
				end,
				desc = "Harpoon goto previous",
			},
		},
	},
	{
		"Mr-LLLLL/interestingwords.nvim",
		config = function()
			require("interestingwords").setup({
				colors = {
					"#f38ba8",
					"#eba0ac",
					"#fab387",
					"#f5e0dc",
					"#a6e3a1",
					"#89dceb",
					"#89b4fa",
					"#b4befe",
					"#cba6f7",
				},
				navigation = true,
				search_count = true,
				color_key = "<leader>m",
				cancel_color_key = "<leader>cm",
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					-- mode = "virtualtext",
				},
			})
		end,
	},
	{
		"mangelozzi/rgflow.nvim",
		config = function()
			require("rgflow").setup({
				cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",
				default_trigger_mappings = true,
				default_ui_mappings = true,
				default_quickfix_mappings = true,
				ui_top_line_char = "━",
			})
		end,
	},
	{
		"xiyaowong/link-visitor.nvim",
		config = function()
			require("link-visitor").setup({
				skip_confirmation = true,
			})
		end,
	},
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			local nvim_tmux_nav = require("nvim-tmux-navigation")

			nvim_tmux_nav.setup({
				disable_when_zoomed = true, -- defaults to false
			})

			local map = require("helpers.keys").map
			map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, "vim tmux left")
			map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, "vim tmux down")
			map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, "vim tmux up")
			map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, "vim tmux right")
			map("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, "vim tmux last active")
		end,
	},
	{
		'jamestthompson3/nvim-remote-containers',
	},
}
