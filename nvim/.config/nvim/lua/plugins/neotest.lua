return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
		},
		opts = {
			-- Can be a list of adapters like what neotest expects,
			-- or a list of adapter names,
			-- or a table of adapter names, mapped to adapter configs.
			-- The adapter will then be automatically loaded with the config.
			adapters = {
				["neotest-go"] = {
					experimental = {
						test_table = true,
					},
					test_command_hook = function(command, position)
						table.insert(command, "--run")
						table.insert(command, position.name)
					end,
					args = { "-v", "-count=1", "-timeout=60s" },
				},
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
		},
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Replace newline and tab characters with space for more compact diagnostics
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)

			local map = require("helpers.keys").map
			map("n", "<leader>tf", function() require("neotest").run.run() end, "[T]est current [f]unction")
			map("n", "<leader>tF", function() require("neotest").run.run(vim.fn.expand('%')) end, "[T]est current [F]ile")
			map("n", "<leader>ts", function() require("neotest").summary.toggle() end, "[T]est [s]ummary")
			map("n", "<leader>to", function() require("neotest").output_panel.toggle() end, "[T]est [o]utput panel")
			map("n", "<leader>tO", function() require("neotest").output.open({ enter = true, auto_close = true }) end,
				"[T]est [O]utput")
			map("n", "<leader>tS", function() require("neotest").run.stop() end, "[T]est [S]top")
			map("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, "[T]est [d]ebug")
		end,
	},
}
