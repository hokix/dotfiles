local M = {}

local function trim(value)
  local result = (value or ""):gsub("^%s+", ""):gsub("%s+$", "")
  return result
end

local function sha1(value)
  local ok, process = pcall(vim.system, { "shasum", "-a", "1" }, { stdin = value, text = true })
  if not ok then
    return nil, process
  end

  local result = process:wait()
  if result.code ~= 0 then
    local message = trim(result.stderr)
    return nil, message ~= "" and message or ("command exited with code " .. result.code)
  end

  local hash = trim(result.stdout):match("^([0-9a-fA-F]+)")
  if not hash then
    return nil, "unable to parse shasum output"
  end
  return hash:lower()
end

local function new_line_positions(diff)
  local positions = {}
  local old_line
  local new_line

  for line in (diff .. "\n"):gmatch("(.-)\r?\n") do
    local old_start, new_start = line:match("^@@ %-(%d+)[^ ]* %+(%d+)[^ ]* @@")
    if old_start then
      old_line = tonumber(old_start)
      new_line = tonumber(new_start)
    elseif old_line and new_line then
      local prefix = line:sub(1, 1)
      if prefix == " " then
        positions[new_line] = { old_line = old_line, new_line = new_line }
        old_line = old_line + 1
        new_line = new_line + 1
      elseif prefix == "+" then
        positions[new_line] = { old_line = 0, new_line = new_line }
        new_line = new_line + 1
      elseif prefix == "-" then
        old_line = old_line + 1
      end
    end
  end

  return positions
end

function M.build_url(changes, location)
  local change
  for _, item in ipairs(changes) do
    if item.new_path == location.relative_path or item.old_path == location.relative_path then
      change = item
      break
    end
  end

  if not change then
    return nil, "current file was not returned by the MR diffs; it may be unchanged or beyond GitLab's diff limits"
  end
  if change.too_large then
    return nil, "GitLab omitted this file because its diff is too large"
  end
  if change.collapsed then
    return nil, "GitLab collapsed this file's diff"
  end
  if type(change.diff) ~= "string" or change.diff == "" then
    return nil, "GitLab did not return a usable diff for this file"
  end

  local positions = new_line_positions(change.diff)
  for line = location.first_line, location.last_line do
    if not positions[line] then
      return nil, ("line %d is not displayed in this MR diff"):format(line)
    end
  end

  local diff_path = change.deleted_file and change.old_path or change.new_path
  local file_hash, hash_err = sha1(diff_path)
  if not file_hash then
    return nil, "failed to calculate the file hash: " .. hash_err
  end

  local position = positions[location.first_line]
  return ("%s/diffs#%s_%d_%d"):format(location.mr_url:gsub("/$", ""), file_hash, position.old_line, position.new_line)
end

return M
