local M = {}

function M.get_os_id()
  local os_name = jit and jit.os:lower() or ""
  if os_name == "osx" then
    return "macos"
  elseif os_name == "windows" then
    return "windows"
  elseif os_name == "linux" then
    local os_release = io.open("/etc/os-release", "r")
    if not os_release then
      return "linux"
    end

    for line in os_release:lines() do
      local id = line:match('^ID="?([%w%-]+)"?$')
      if id then
        os_release:close()
        return id
      end
    end

    os_release:close()
    return ""
  end
  return ""
end

return M
