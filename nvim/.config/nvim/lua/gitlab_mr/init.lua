local M = {}
local api = require("gitlab_mr.api")
local diff = require("gitlab_mr.diff")

local title = "MRDiffLink"

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = title })
end

local function ensure_executable(name)
  if vim.fn.executable(name) ~= 1 then
    notify(("Dependency `%s` is required. Please install it first."):format(name), vim.log.levels.WARN)
    return false
  end
  return true
end

local function trim(value)
  local result = (value or ""):gsub("^%s+", ""):gsub("%s+$", "")
  return result
end

local function system_wait(args, opts)
  opts = vim.tbl_extend("force", { text = true }, opts or {})
  local ok, process = pcall(vim.system, args, opts)
  if not ok then
    return nil, process
  end

  local result = process:wait()
  if result.code ~= 0 then
    local message = trim(result.stderr)
    return nil, message ~= "" and message or ("command exited with code " .. result.code)
  end
  return trim(result.stdout)
end

local function parse_mr_ref(value, current_project)
  value = trim(value)

  local project, mr_iid = value:match("^(.+)!([1-9]%d*)$")
  if not project then
    project, mr_iid = value:match("^https?://[^/]+/(.-)/-/merge_requests/([1-9]%d*)")
  end
  if project then
    return project, tonumber(mr_iid)
  end

  if value:match("^[1-9]%d*$") then
    return current_project, tonumber(value)
  end
end

function M.run(cmd)
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    notify("current buffer is not a file", vim.log.levels.ERROR)
    return
  end
  if not ensure_executable("git") then
    return
  end
  if not ensure_executable("glab") then
    return
  end
  if vim.bo.modified then
    notify("save the current buffer before generating an MR link", vim.log.levels.ERROR)
    return
  end

  local root, root_err = system_wait({ "git", "-C", vim.fs.dirname(name), "rev-parse", "--show-toplevel" })
  if not root then
    notify("unable to find the Git repository: " .. root_err, vim.log.levels.ERROR)
    return
  end

  local ok, relative_path = pcall(vim.fs.relpath, root, name)
  if not ok or not relative_path or relative_path == "" or relative_path == "." then
    notify("unable to calculate the repository-relative path", vim.log.levels.ERROR)
    return
  end

  local file_status, status_err = system_wait({
    "git",
    "-C",
    root,
    "status",
    "--porcelain=v1",
    "--untracked-files=normal",
    "--",
    relative_path,
  })
  if not file_status then
    notify("unable to inspect the current file: " .. status_err, vim.log.levels.ERROR)
    return
  end
  if file_status ~= "" then
    notify("commit, stash, or restore changes to the current file before generating an MR link", vim.log.levels.ERROR)
    return
  end

  local local_head, head_err = system_wait({ "git", "-C", root, "rev-parse", "HEAD" })
  if not local_head then
    notify("unable to read the local HEAD: " .. head_err, vim.log.levels.ERROR)
    return
  end

  local first_line
  local last_line
  if cmd.range > 0 then
    first_line = cmd.line1
    last_line = cmd.line2
  else
    first_line = vim.api.nvim_win_get_cursor(0)[1]
    last_line = first_line
  end

  local branch
  if trim(cmd.args) == "" then
    local branch_err
    branch, branch_err = system_wait({ "git", "-C", root, "branch", "--show-current" })
    if not branch then
      notify("unable to read the current branch: " .. branch_err, vim.log.levels.ERROR)
      return
    end
  end

  api.request_json(root, "projects/:fullpath", function(project, project_err)
    if not project then
      if
        project_err:find("none of the git remotes configured for this repository point to a known GitLab", 1, true)
      then
        notify("MRDiffLink is only available in GitLab repositories configured in glab", vim.log.levels.WARN)
        return
      end
      notify("unable to resolve the current GitLab project: " .. project_err, vim.log.levels.ERROR)
      return
    end
    if type(project.id) ~= "number" or type(project.path_with_namespace) ~= "string" then
      notify("GitLab returned incomplete project metadata", vim.log.levels.ERROR)
      return
    end

    local function use_mr(mr)
      if
        type(mr) ~= "table"
        or type(mr.iid) ~= "number"
        or type(mr.target_project_id) ~= "number"
        or type(mr.sha) ~= "string"
        or type(mr.web_url) ~= "string"
      then
        notify("GitLab returned incomplete MR metadata", vim.log.levels.ERROR)
        return
      end
      if mr.sha ~= local_head then
        notify(
          ("local HEAD %s does not match MR !%d head %s"):format(local_head:sub(1, 12), mr.iid, mr.sha:sub(1, 12)),
          vim.log.levels.ERROR
        )
        return
      end

      local location = {
        first_line = first_line,
        last_line = last_line,
        mr_url = mr.web_url,
        relative_path = relative_path,
      }
      api.request_mr_diffs(root, mr.target_project_id, mr.iid, function(changes, request_err)
        if not changes then
          notify("GitLab diff request failed: " .. request_err, vim.log.levels.ERROR)
          return
        end

        local url, build_err = diff.build_url(changes, location)
        if not url then
          notify(build_err, vim.log.levels.ERROR)
          return
        end

        vim.fn.setreg("+", url)
        if cmd.bang then
          local ok_open, open_process, open_err = pcall(vim.ui.open, url)
          if not ok_open or not open_process then
            local message = ok_open and open_err or open_process
            notify(
              "link copied, but opening it failed: " .. tostring(message or "no opener available"),
              vim.log.levels.WARN
            )
            return
          end
        end

        local suffix = location.last_line > location.first_line
            and ("; select lines %d-%d in GitLab to add a range comment"):format(
              location.first_line,
              location.last_line
            )
          or ""
        notify("Copied " .. url .. suffix)
      end)
    end

    local function fetch_mr(project_path, mr_iid)
      local endpoint = ("projects/%s/merge_requests/%d"):format(api.encode_component(project_path), mr_iid)
      api.request_json(root, endpoint, function(mr, request_err)
        if not mr then
          notify("MR lookup failed: " .. request_err, vim.log.levels.ERROR)
          return
        end
        use_mr(mr)
      end)
    end

    local function prompt_for_mr()
      vim.ui.input({ prompt = "MR: " }, function(value)
        if value == nil or trim(value) == "" then
          return
        end

        local project_path, mr_iid = parse_mr_ref(value, project.path_with_namespace)
        if not project_path then
          notify("enter an MR number, project!number, or MR URL", vim.log.levels.ERROR)
          return
        end
        fetch_mr(project_path, mr_iid)
      end)
    end

    if trim(cmd.args) ~= "" then
      local project_path, mr_iid = parse_mr_ref(cmd.args, project.path_with_namespace)
      if not project_path then
        notify("enter an MR number, project!number, or MR URL", vim.log.levels.ERROR)
        return
      end
      fetch_mr(project_path, mr_iid)
      return
    end

    if branch == "" then
      prompt_for_mr()
      return
    end

    local endpoint = ("merge_requests?scope=all&state=opened&source_branch=%s&per_page=100"):format(
      api.encode_component(branch)
    )
    api.request_json(root, endpoint, function(merge_requests, request_err)
      if not merge_requests then
        notify("MR lookup failed: " .. request_err, vim.log.levels.ERROR)
        return
      end

      local candidates = {}
      for _, mr in ipairs(merge_requests) do
        if mr.source_project_id == project.id or mr.target_project_id == project.id then
          table.insert(candidates, mr)
        end
      end

      if #candidates == 0 then
        prompt_for_mr()
        return
      end
      if #candidates == 1 then
        use_mr(candidates[1])
        return
      end

      vim.ui.select(candidates, {
        prompt = "MR: ",
        format_item = function(item)
          local reference = item.references and item.references.full or ("!%d"):format(item.iid)
          return ("%s %s"):format(reference, item.title or "")
        end,
      }, function(choice)
        if choice then
          use_mr(choice)
        end
      end)
    end, true)
  end)
end

return M
