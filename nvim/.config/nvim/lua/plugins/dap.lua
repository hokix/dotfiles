return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "cpptools" })
        end
      end,
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["cpptools"] then
        require("dap").adapters["cpptools"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = {
              "--port",
              "${port}",
            },
          },
        }
      end
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "cppdbg",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = function()
              return vim.fn.input("Path to cwd: ", vim.fn.getcwd() .. "/", "file")
            end,
            MIMode = "gdb",
            miDebuggerPath = "/usr/bin/gdb",
            setupCommands = {
                {
                    description = "Enable pretty-printing for gdb",
                    text= "-enable-pretty-printing",
                    ignoreFailures = true
                },
                {
                    description = "Enable follow child for gdb",
                    text= "-gdb-set follow-fork-mode child",
                    ignoreFailures = true
                }
            }
          },
          {
            type = "cppdbg",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end

      -- setup dap config by VsCode launch.json file
      require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })

    end
  },
}
