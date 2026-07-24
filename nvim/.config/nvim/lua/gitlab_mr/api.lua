local M = {}

local function trim(value)
  local result = (value or ""):gsub("^%s+", ""):gsub("%s+$", "")
  return result
end

function M.encode_component(value)
  local encoded = value:gsub("([^%w%-._~])", function(char)
    return string.format("%%%02X", string.byte(char))
  end)
  return encoded
end

function M.request_json(root, endpoint, callback, paginate)
  local args = { "glab", "api", endpoint }
  if paginate then
    table.insert(args, "--paginate")
  end

  local ok_system, process = pcall(vim.system, args, { cwd = root, text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        local message = trim(result.stderr)
        message = message ~= "" and message or ("command exited with code " .. result.code)
        callback(nil, message, {
          exit_code = result.code,
          http_status = tonumber(message:match("HTTP%s+(%d%d%d)")),
        })
        return
      end

      local ok_json, data = pcall(vim.json.decode, result.stdout)
      if not ok_json or type(data) ~= "table" then
        callback(nil, "unable to decode the GitLab API response")
        return
      end
      callback(data)
    end)
  end)

  if not ok_system then
    callback(nil, "unable to start glab: " .. tostring(process))
  end
end

function M.request_mr_diffs(root, project_id, mr_iid, callback)
  local base_endpoint = ("projects/%d/merge_requests/%d"):format(project_id, mr_iid)
  M.request_json(root, base_endpoint .. "/diffs?per_page=100", function(changes, request_err, details)
    if changes then
      callback(changes)
      return
    end
    if not details or details.http_status ~= 404 then
      callback(nil, request_err)
      return
    end

    M.request_json(root, base_endpoint .. "/changes?access_raw_diffs=true", function(legacy, legacy_err)
      if not legacy then
        callback(nil, ("%s; legacy changes request failed: %s"):format(request_err, legacy_err))
        return
      end
      if type(legacy.changes) ~= "table" then
        callback(nil, "legacy changes response did not contain a changes array")
        return
      end
      callback(legacy.changes)
    end)
  end, true)
end

return M
