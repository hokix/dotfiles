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
            cmd = { "npx", "--yes", "gitnexus@latest", "analyze", "--index-only", "--pdg" },
          }
        end,
        desc = "Run gitnexus analyze.",
      },
    })
  end,
}
