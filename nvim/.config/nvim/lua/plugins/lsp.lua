-- LSP Configuration & Plugins
local set_lsp_keymaps = function(bufnr)
	local map = require("helpers.keys").map
	local lsp_map = require("helpers.keys").lsp_map

	lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
	lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
	lsp_map("<leader>ll", vim.lsp.codelens.run, bufnr, "[L]SP Code [L]ens")
	lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "[L]SP Type [D]efinition")
	lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "[L]SP Document [S]ymbols")

	lsp_map("gd", vim.lsp.buf.definition, bufnr, "[G]oto [D]efinition")
	lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "[G]oto [R]eferences")
	lsp_map("gi", vim.lsp.buf.implementation, bufnr, "[G]oto [I]mplementation")
	lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
	lsp_map("gD", vim.lsp.buf.declaration, bufnr, "[G]oto [D]eclaration")

	-- diagnostic
	map("n", "]d", vim.diagnostic.goto_next, "Next [D]iagnostic")
	map("n", "[d", vim.diagnostic.goto_prev, "Previous [D]iagnostic")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })

	lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "[F]ormat")
end

local M = {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"folke/neodev.nvim",
			"RRethy/vim-illuminate",
			"hrsh7th/cmp-nvim-lsp",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			-- Set up Mason before anything else
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pylsp",
					"gopls",
				},
				automatic_installation = true,
			})
			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {
					function(config)
						-- all sources with no handler get passed here

						-- Keep original functionality
						require("mason-nvim-dap").default_setup(config)
					end,
				},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					"delve",
					"cpptools",
				},
			})

			-- Quick access via keymap
			require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show [M]ason")

			-- Dap
			local dap = require("dap")
			local widgets = require("dap.ui.widgets")
			local dapui = require("dapui")
			dapui.setup({
				floating = {
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "󰟃", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })

			local dap_map = require("helpers.keys").dap_map
			dap_map("n", "<F5>", function()
				if vim.fn.filereadable(".vscode/launch.json") then
					require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
				end
				dap.continue()
			end, "DAP Continue")
			dap_map("n", "<F10>", function()
				dap.step_over()
			end, "DAP Step Over")
			dap_map("n", "<F11>", function()
				dap.step_into()
			end, "DAP Setp Into")
			dap_map("n", "<F12>", function()
				dap.step_out()
			end, "DAP Step Out")
			dap_map("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, "[D]AP Toggle [B]reakpoint")
			dap_map("n", "<leader>dB", function()
				dap.set_breakpoint()
			end, "[D]AP Set [B]reakpoint")
			dap_map("n", "<leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, "[D]AP Set Break[p]oint(args)")
			dap_map("n", "<leader>dr", function()
				dap.repl.open()
			end, "[D]AP [R]epl Open")
			dap_map("n", "<leader>dl", function()
				dap.run_last()
			end, "[D]AP Run [L]ast")
			dap_map({ "n", "v" }, "<leader>dh", function()
				-- widgets.hover(nil, { border = "rounded" })
				dapui.eval()
			end, "[D]AP [H]over")
			dap_map("n", "<leader>df", function()
				-- widgets.centered_float(widgets.frames, { border = "rounded" })
				require("dapui").float_element("stacks", { enter = true })
			end, "[D]AP Centered Float [F]rame")
			dap_map("n", "<leader>ds", function()
				-- widgets.centered_float(widgets.scopes, { border = "rounded" })
				require("dapui").float_element("scopes", { enter = true })
			end, "[D]AP Centered Float [S]cope")

			-- dap virtual text
			require("nvim-dap-virtual-text").setup()

			-- use launch.js
			require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

			-- Neodev setup before LSP config
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})

			-- Set up cool signs for diagnostics
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- Diagnostic config
			local config = {
				-- virtual_text = false,
				underlines = false,
				-- inlay_hints = {
				-- background = false,
				-- },
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}
			vim.diagnostic.config(config)

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
			})

			-- This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(client, bufnr)
				set_lsp_keymaps(bufnr)
				-- Attach and configure vim-illuminate
				require("illuminate").on_attach(client)
			end

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"leoluz/nvim-dap-go",
		},
		config = function()
			require("guihua.maps").setup({
				maps = {
					close_view = "<C-x>",
					send_qf = "<C-q>",
					save = "<C-s>",
					jump_to_list = "<C-w>k",
					jump_to_preview = "<C-w>j",
					prev = "<C-p>",
					next = "<C-n>",
					pageup = "<C-b>",
					pagedown = "<C-f>",
					confirm = "<C-o>",
					split = "<C-s>",
					vsplit = "<C-v>",
					tabnew = "<C-t>",
				},
			})
			require("go").setup({
				verbose = true,
				log_path = vim.fn.expand("~") .. "/.local/state/nvim/gonvim.log",
				goimport = "gopls",
				fillstruct = "gopls",
				-- tag_options = "json=",
				dap_debug = true,
				dap_debug_gui = true,
				dap_debug_keymap = false,
				lsp_cfg = false,
				lsp_on_attach = false,
				lsp_keymaps = function(bufnr)
					set_lsp_keymaps(bufnr)
				end,
				lsp_inlay_hints = {
					enable = true,
				},
				diagnostic = {
					underline = false,
				},
				icons = true,
				run_in_floaterm = false,
				trouble = true,
			})

			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
			-- dap-go
			require("dap-go").setup()
			require("helpers.keys").map("n", "<leader>td", function()
				require("dap-go").debug_test()
				-- neotest-go dose not support dap yet
				-- require("neotest").run.run({ strategy = "dap" })
			end, "[T]est [D]ebug")

			local cfg = require("go.lsp").config()
			require("lspconfig").gopls.setup(cfg)
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	-- {
	-- 	"jay-babu/mason-nvim-dap.nvim",
	-- 	dependencies = "mason.nvim",
	-- 	cmd = { "DapInstall", "DapUninstall" },
	-- 	opts = {
	-- 		-- Makes a best effort to setup the various debuggers with
	-- 		-- reasonable debug configurations
	-- 		automatic_installation = true,
	--
	-- 		-- You can provide additional configuration to the handlers,
	-- 		-- see mason-nvim-dap README for more information
	-- 		handlers = {
	-- 			function(config)
	-- 				-- all sources with no handler get passed here
	--
	-- 				-- Keep original functionality
	-- 				require("mason-nvim-dap").default_setup(config)
	-- 			end,
	-- 		},
	--
	-- 		-- You'll need to check that you have the required things installed
	-- 		-- online, please don't ask me how to install them :)
	-- 		ensure_installed = {
	-- 			-- Update this to ensure that you have the debuggers for the langs you want
	-- 			"delve",
	-- 			"cppdbg",
	-- 		},
	-- 	},
	-- },
	{
		"nvimdev/lspsaga.nvim",
		-- event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				ui = {
					border = "rounded",
					code_action = " ",
				},
				lightbulb = {
					enable = false,
					-- sign = false,
				},
				code_action = {
					show_server_name = true,
					extend_gitsigns = true,
				},
			})
			require("helpers.keys").map({ "n", "t" }, "<leader>tm", "<cmd>Lspsaga term_toggle<cr>", "[T]oggle Ter[m]inal")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("helpers.keys").map("n", "<leader>xt", "<cmd>TroubleToggle<cr>", "[Tr]ouble [T]oggle")
			require("helpers.keys").map("n", "<leader>xc", "<cmd>TroubleClose<cr>", "[Tr]ouble [C]lose")
		end,
	},
}

return M
