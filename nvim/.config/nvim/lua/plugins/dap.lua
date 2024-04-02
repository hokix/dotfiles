return {
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      require("dap.ext.vscode").load_launchjs()
    end,
  },
}
