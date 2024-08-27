return {
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    -- init = function()
    opts = function(_, opts)
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.stdpath("config") .. "/luasnippets/" },
      })
    end,
  },
}
