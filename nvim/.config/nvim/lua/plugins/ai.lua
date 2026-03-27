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
      opts = {
        provider = "copilot",
        providers = {
          copilot = {
            model_id = "claude-sonnet-4.6",
          },
        },
      },
      lazy = true,
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
          mux = {
            enabled = true,
            backend = "tmux",
          },
        },
      },
    },
  },
}
