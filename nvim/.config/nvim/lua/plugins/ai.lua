return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    cmd = "MCPHub", -- lazy load
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        extensions = {
          avante = {
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
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
          return env
        end,
      })
    end,
    lazy = true,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    dependencies = {
      "ravitemer/mcphub.nvim",
    },
    opts = {
      model = "claude-sonnet-4.5",
      window = {
        width = math.floor(vim.o.columns * 0.3),
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- extensions
      "ravitemer/mcphub.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "codecompanion" },
        },
        ft = { "markdown", "codecompanion" },
      },
      {
        "saghen/blink.cmp",
        optional = true,
        opts = {
          sources = {
            default = { "codecompanion" },
            providers = {
              -- other providers
              codecompanion = {
                name = "CodeCompanion",
                module = "codecompanion.providers.completion.blink",
                enabled = true,
                score_offset = 10,
                async = true,
              },
            },
          },
        },
      },
    },
    lazy = true,
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    keys = {
      {
        "<leader>aCa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>aCx",
        "<cmd>CodeCompanionChat RefreshCache<cr>",
        desc = "Clear (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>aCq",
        "<cmd>CodeCompanion<cr>",
        desc = "Quick Chat (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>aCp",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Prompt Actions (CodeCompanion)",
        mode = { "n", "v" },
      },
    },
    opts = {
      display = {
        chat = {
          window = {
            position = "right",
            width = 0.3,
          },
        },
        strategies = {
          chat = {
            -- adapter = "deepseek",
            adapter = "copilot",
            model = "claude-sonnet-4.5",
          },
          inline = {
            -- adapter = "deepseek",
            adapter = "copilot",
            model = "claude-sonnet-4.5",
          },
          cmd = {
            -- adapter = "deepseek",
            adapter = "copilot",
            model = "claude-sonnet-4.5",
          },
        },
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            schema = {
              model = {
                default = "deepseek-chat",
              },
            },
          })
        end,
      },
      prompt_library = {
        ["Diff code review"] = {
          strategy = "chat",
          description = "Perform a code review",
          opts = {
            auto_submit = true,
            user_prompt = false,
          },
          prompts = {
            {
              role = "user",
              content = function()
                local target_branch = vim.fn.input("Target branch for merge base diff (default: master): ", "master")

                return string.format(
                  [[
          You are a senior software engineer performing a code review. Analyze the following code changes.
           Identify any potential bugs, performance issues, security vulnerabilities, or areas that could be refactored for better readability or maintainability.
           Explain your reasoning clearly and provide specific suggestions for improvement.
           Consider edge cases, error handling, and adherence to best practices and coding standards.
           Here are the code changes:
           ```
            %s
           ```
           ]],
                  vim.fn.system("git diff --merge-base " .. target_branch)
                )
              end,
            },
          },
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true, -- Show tool results directly in chat buffer
            format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
            -- MCP Resources
            make_vars = true, -- Convert MCP resources to #variables for prompts
            -- MCP Prompts
            make_slash_commands = true, -- Add MCP prompts as /slash commands
          },
        },
      },
    },
  },
  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "Code Companion",
        size = { width = 50 },
      })
    end,
  },
  -- lualine integration
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    dependencies = {
      "franco-ruggeri/codecompanion-lualine.nvim",
      -- Other dependencies
    },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "codecompanion")
    end,
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
          { "<leader>aC", group = "CodeCompanion" },
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
