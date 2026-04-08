---@diagnostic disable: undefined-global
return {
  generator = function(search, cb)
    if vim.fn.finddir(".git", search.dir .. ";") == "" then
      cb({})
      return
    end
    cb({
      {
        name = "gitnexus analyze",
        builder = function()
          return {
            cmd = { "npx", "gitnexus", "analyze" },
          }
        end,
        desc = "Run gitnexus analyze.",
      },
    })
  end,
}
