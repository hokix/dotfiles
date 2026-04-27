local util = require("overseer.util")

---@param self table
---@param height nil|integer
---@param focus boolean
local function copen(self, height, focus)
  if self.qf_opened then return end
  local open_cmd = height and ("botright copen " .. height) or "botright copen"
  local winid = vim.api.nvim_get_current_win()
  vim.cmd(open_cmd)
  if not focus then vim.api.nvim_set_current_win(winid) end
  self.qf_opened = true
end

-- Expand wire's multi-line "needed by" chain into individual wire: FILE:LINE:COL lines
-- so that getqflist creates one navigable entry per dependency hop.
--
-- Wire emits:
--   wire: /abs/file.go:14:1: inject X: no provider found for T
--   \tneeded by T2 in provider set "S" (/abs/file2.go:10:6)
--   \tneeded by error in provider "func" (/abs/file3.go:24:6)
--
-- Each continuation is rewritten to:  wire: /abs/file2.go:10:6: needed by T2 in provider set "S"
local function expand_wire_lines(lines)
  local out = {}
  local wf, wl, wc -- parent wire error location (fallback)
  for _, line in ipairs(lines) do
    local f, l, c = line:match("^wire: ([^:]+):(%d+):(%d+):")
    if f then
      wf, wl, wc = f, l, c
      table.insert(out, line)
    elseif wf and line:match("^\t") then
      -- Extract embedded (FILE:LINE:COL) at end: "\tMSG (FILE:LINE:COL)"
      local msg, ef, el, ec = line:match("^\t(.+) %(([^:]+):(%d+):(%d+)%)$")
      if ef then
        table.insert(out, ("wire: %s:%s:%s: %s"):format(ef, el, ec, msg))
      else
        -- No embedded location; attach to parent wire.go position
        local msg2 = line:match("^\t(.+)") or ""
        table.insert(out, ("wire: %s:%s:%s: %s"):format(wf, wl, wc, msg2))
      end
    else
      if not line:match("^\t") then wf = nil end
      table.insert(out, line)
    end
  end
  return out
end

---@type overseer.ComponentFileDefinition
return {
  desc = "Expand wire multi-line errors into individual quickfix entries on task completion",
  params = {
    errorformat = {
      desc = "See :help errorformat",
      type = "string",
      default = "wire: %f:%l:%c: %m,%f:%l:%c: %m,%-G%.%#",
    },
    open_on_exit = {
      type = "enum",
      choices = { "never", "failure", "always" },
      default = "failure",
    },
    open_height = {
      type = "integer",
      optional = true,
      validate = function(v) return v > 0 end,
    },
    close = {
      desc = "Close the quickfix on completion if no matches",
      type = "boolean",
      default = true,
    },
    focus = {
      type = "boolean",
      default = false,
    },
  },
  constructor = function(params)
    return {
      qf_id = 0,
      qf_opened = false,
      on_reset = function(self)
        self.qf_id = 0
        self.qf_opened = false
      end,
      on_exit = function(self, _, code)
        local open = params.open_on_exit == "always"
          or (params.open_on_exit == "failure" and code ~= 0)
        if open then copen(self, params.open_height, params.focus) end
      end,
      on_pre_result = function(self, task)
        local bufnr = task:get_bufnr()
        if not bufnr then return end
        local raw = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
        local lines = expand_wire_lines(raw)

        local prev_context = vim.fn.getqflist({ context = 0 }).context
        local action = (prev_context == task.id or self.qf_id ~= 0) and "r" or " "

        local items
        util.run_in_cwd(task.cwd, function()
          items = vim.fn.getqflist({ lines = lines, efm = params.errorformat }).items
        end)

        local valid_items = vim.tbl_filter(function(i) return i.valid == 1 end, items)

        local what = { title = task.name, context = task.id, items = valid_items }
        if self.qf_id ~= 0 then what.id = self.qf_id end
        vim.fn.setqflist({}, action, what)
        if self.qf_id == 0 then
          self.qf_id = vim.fn.getqflist({ id = 0 }).id
        end

        if vim.tbl_isempty(valid_items) and params.close then
          vim.cmd("cclose")
        end
      end,
    }
  end,
}
