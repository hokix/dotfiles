return {

  -- Set up nvim-jdtls to attach to java files.
  -- override lazyvim default since custom java is needed
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    optional = true,
    -- ft = java_filetypes,
    opts = function()
      local cmd = { vim.fn.exepath("jdtls") } -- Can be empty if executed too early
      if LazyVim.has("mason.nvim") then
        local mason_registry = require("mason-registry")
        local lombok_jar = mason_registry.get_package("jdtls"):get_install_path() .. "/lombok.jar"
        -- Should be re-executed after require("mason-registry") to get a real value
        cmd = { vim.fn.exepath("jdtls") }
        local uname = io.popen("uname"):read("*l")
        if uname == "Darwin" then
          table.insert(cmd, "--java-executable=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home/bin/java")
        elseif uname == "Linux" then
          local utils = require("config.utils")
          local os_id = utils.get_os_id()
          if os_id == "ubuntu" then
            table.insert(cmd, "--java-executable=/usr/lib/jvm/java-21-openjdk-amd64/bin/java")
          elseif os_id == "centos" then
            table.insert(cmd, "--java-executable=/usr/lib/jvm/openjdk-21_linux-x64/bin/java")
          end
        end
        table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
      end
      return {
        -- How to find the root dir for a given filename. The default comes from
        -- lspconfig which provides a function specifically for java projects.
        root_dir = LazyVim.lsp.get_raw_config("jdtls").default_config.root_dir,

        -- How to find the project name for a given root dir.
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        -- Where are the config and workspace dirs for a project?
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,

        -- How to run jdtls. This can be overridden to a full java command-line
        -- if the Python wrapper script doesn't suffice.
        cmd = cmd,
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,
      }
    end,
  },
  {
    "oclay1st/maven.nvim",
    cmd = { "Maven", "MavenInit", "MavenExec" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {}, -- options, see default configuration
    lazy = true,
  },
}
