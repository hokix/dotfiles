---@diagnostic disable: undefined-global
return {
  generator = function(search, cb)
    if vim.fn.finddir(".git", search.dir .. ";") == "" then
      cb({})
      return
    end
    cb({
      {
        name = "graphify install",
        builder = function()
          return {
            name = "graphify install",
            strategy = {
              "orchestrator",
              tasks = {
                {
                  cmd = { "graphify" },
                  args = { "copilot", "install" },
                },
                {
                  cmd = { "graphify" },
                  args = { "opencode", "install" },
                },
              },
            },
          }
        end,
        desc = "Run graphify install.",
      },
    })
  end,
}
