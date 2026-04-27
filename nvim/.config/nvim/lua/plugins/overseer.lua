---@diagnostic disable: undefined-global
return {
  "stevearc/overseer.nvim",
  opts = {
    component_aliases = {
      open_output_on_failure = {
        { "on_output_quickfix", open_on_exit = "failure", items_only = true, close = true },
      },
    },
  },
  keys = {
    {
      "<leader>oo",
      function()
        local overseer = require("overseer")
        require("overseer.template").list({
          dir = vim.fn.getcwd(),
          filetype = vim.bo.filetype,
        }, function(templates)
          templates = vim.tbl_filter(function(t)
            return not t.hide
          end, templates)
          if #templates == 0 then
            vim.notify("No task templates found", vim.log.levels.WARN)
            return
          end
          vim.ui.select(templates, {
            prompt = "Task template:",
            kind = "overseer_template",
            format_item = function(tmpl)
              if tmpl.desc then
                return string.format("%s (%s)", tmpl.name, tmpl.desc)
              end
              return tmpl.name
            end,
          }, function(tmpl)
            if tmpl then
              overseer.run_task({ name = tmpl.name, first = true })
            end
          end)
        end)
      end,
      desc = "Run task",
    },
  },
}
