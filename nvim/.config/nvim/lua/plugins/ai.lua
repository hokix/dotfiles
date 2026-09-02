return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    cmd = "MCPHub", -- lazy load
    -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        use_bundled_binary = true,
        extensions = {
          copilotchat = {
            enabled = true,
            convert_tools_to_functions = true, -- Convert MCP tools to CopilotChat functions
            convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
            add_mcp_prefix = true, -- Add "mcp_" prefix to function names
          },
        },
        global_env = function(context)
          local env = {}
          if context.is_working_mode then
            env.ALLOWED_DIRECTORY = context.working_root
          end
          if vim.fn.filereadable("/var/run/docker.sock") == 1 then
            env.DOCKER_HOST = "unix:///var/run/docker.sock"
          elseif vim.fn.filereadable(vim.fn.expand("$HOME/.lima/default/sock/docker.sock")) == 1 then
            -- lima for macos docker
            env.DOCKER_HOST = "unix://" .. vim.fn.expand("$HOME/.lima/default/sock/docker.sock")
          end
          return env
        end,
      })
    end,
    lazy = true,
  },
  {
    {
      "piersolenski/wtf.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
      },
      lazy = true,
      opts = {
        provider = "copilot",
        providers = {
          copilot = {
            model_id = "claude-sonnet-4.6",
          },
        },
      },
      keys = {
        {
          "<leader>cwd",
          mode = { "n", "x" },
          function()
            require("wtf").diagnose()
          end,
          desc = "Debug diagnostic with AI",
        },
        {
          "<leader>cwf",
          mode = { "n", "x" },
          function()
            require("wtf").fix()
          end,
          desc = "Fix diagnostic with AI",
        },
        {
          mode = { "n" },
          "<leader>cws",
          function()
            require("wtf").search()
          end,
          desc = "Search diagnostic with Google",
        },
        {
          mode = { "n" },
          "<leader>cwp",
          function()
            require("wtf").pick_provider()
          end,
          desc = "Pick provider",
        },
        {
          mode = { "n" },
          "<leader>cwh",
          function()
            require("wtf").history()
          end,
          desc = "Populate the quickfix list with previous chat history",
        },
      },
    },
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        spec = {
          { "<leader>cw", group = "wtf" },
        },
      },
    },
    {
      "folke/sidekick.nvim",
      optional = true,
      opts = {
        -- add any options here
        cli = {
          win = {
            keys = {
              shift_enter = {
                "<S-CR>",
                function(terminal)
                  -- Send kitty keyboard protocol shift+enter directly to the job
                  vim.api.nvim_chan_send(terminal.job, "\27[13;2u")
                end,
                mode = "t",
                desc = "send shift+enter to terminal",
              },
            },
          },
          mux = {
            enabled = true,
            backend = "herdr",
          },
          tools = {
            codewhale = {
              cmd = { "codewhale" },
            },
            omp = {
              cmd = { "omp" },
            },
          },
        },
      },
      config = function(_, opts)
        local Herdr = {}
        Herdr.__index = Herdr
        Herdr.priority = 50

        local function herdr_json(args)
          local out = vim.trim(vim.fn.system(vim.list_extend({ "herdr" }, args)))
          if vim.v.shell_error ~= 0 or out == "" then
            return nil
          end
          local ok, result = pcall(vim.fn.json_decode, out)
          return ok and result or nil
        end

        local function attach_cmd(self)
          if self.herdr_terminal_id then
            return { cmd = { "herdr", "terminal", "attach", self.herdr_terminal_id } }
          end
        end

        function Herdr:init()
          self.is_running = function(s)
            return s.herdr_pane_id and herdr_json({ "pane", "get", s.herdr_pane_id }) ~= nil
          end
        end

        function Herdr:start()
          local Util = require("sidekick.util")
          local r = herdr_json({ "workspace", "create", "--cwd", self.cwd, "--label", self.tool.name, "--no-focus" })
          if not (r and r.result and r.result.root_pane) then
            Util.error("herdr: failed to create workspace")
            return nil
          end

          local pid = r.result.root_pane.pane_id
          self.id = pid
          self.herdr_pane_id = pid
          self.mux_session = r.result.workspace.workspace_id
          self.started = true
          self.mux_backend = "herdr"

          local cmd = table.concat(vim.tbl_map(vim.fn.shellescape, self.tool.cmd), " ")
          herdr_json({ "pane", "run", pid, cmd })

          local pi = herdr_json({ "pane", "get", pid })
          if pi and pi.result and pi.result.pane then
            self.herdr_terminal_id = pi.result.pane.terminal_id
          end

          Util.info(("Started **%s** in herdr workspace"):format(self.tool.name))
          return attach_cmd(self)
        end

        function Herdr:attach()
          return attach_cmd(self)
        end

        function Herdr:send(text)
          if self.herdr_pane_id then
            vim.fn.system({ "herdr", "pane", "send-text", self.herdr_pane_id, text })
          end
        end

        function Herdr:submit()
          if self.herdr_pane_id then
            vim.fn.system({ "herdr", "pane", "send-keys", self.herdr_pane_id, "enter" })
          end
        end

        function Herdr.sessions()
          local tools = require("sidekick.config").tools()
          local r = herdr_json({ "pane", "list" })
          if not (r and r.result and r.result.panes) then
            return {}
          end

          local ret = {}
          local Procs = require("sidekick.cli.procs")
          local procs = Procs.new()

          for _, pane in ipairs(r.result.panes) do
            local pi = herdr_json({ "pane", "process-info", "--pane", pane.pane_id })
            if pi and pi.result and pi.result.process_info then
              local info = pi.result.process_info
              local pid = (
                info.foreground_processes
                and info.foreground_processes[1]
                and info.foreground_processes[1].pid
              ) or info.shell_pid
              if pid then
                local cwd = (
                  info.foreground_processes
                  and info.foreground_processes[1]
                  and info.foreground_processes[1].cwd
                ) or pane.cwd
                procs:walk(pid, function(proc)
                  for _, tool in pairs(tools) do
                    if tool:is_proc(proc) then
                      ret[#ret + 1] = {
                        id = pane.pane_id,
                        cwd = cwd,
                        tool = tool,
                        herdr_pane_id = pane.pane_id,
                        herdr_terminal_id = pane.terminal_id,
                        mux_session = pane.workspace_id,
                        pids = Procs.pids(pid),
                      }
                      return true
                    end
                  end
                end)
              end
            end
          end

          return ret
        end

        if vim.fn.executable("herdr") == 1 then
          local ok, session = pcall(require, "sidekick.cli.session")
          if ok then
            session.register("herdr", Herdr)
          end
        end

        -- Validation runs inside vim.schedule() in Config.setup() —
        -- patch must stay active until that async callback fires.
        local config = require("sidekick.config")
        local _validate = config.validate
        config.validate = function(key, t)
          if key == "cli.mux.backend" then
            t = vim.list_extend(vim.deepcopy(t), { "herdr" })
          end
          return _validate(key, t)
        end
        require("sidekick").setup(opts)
        vim.schedule(function()
          config.validate = _validate
        end)
      end,
    },
  },
}
