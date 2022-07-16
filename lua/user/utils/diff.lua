local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

---@diagnostic disable-next-line: unused-function
local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

local function get_all_commits_of_this_file()
  local scripts = vim.api.nvim_exec("!git log --pretty=oneline --abbrev-commit --follow %", true)
  local res = vim.split(scripts, "\n")
  local output = {}
  for index = 3, #res - 1 do
    local item = res[index]
    local hash_id = string.sub(item, 1, 7)
    local message = string.sub(item, 8)
    output[index - 2] = { hash_id = hash_id, message = message }
  end
  return output
end

local function diffWith()
  local commits = get_all_commits_of_this_file();

  vim.ui.select(commits, {
    prompt = "Select commit to compare with current file",
    format_item = function(item)
      return item.hash_id .. " > " .. item.message
    end,
  }, function(choice)
    gitsigns.diffthis(choice.hash_id)
    -- With vim-fugitive
    -- vim.cmd("Gvdiffsplit " .. choice.hash_id)
  end)
end

return diffWith
