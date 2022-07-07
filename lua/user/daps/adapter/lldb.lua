-- Adjust the path to your executable
local is_unix = vim.fn.has("unix") == 1
local is_win32 = vim.fn.has("win32") == 1
local is_wsl = vim.fn.has("wsl") == 1
local extension_path
local cmd

if is_wsl then
  extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.7.0/"
  cmd = extension_path .. "adapter/codelldb"
elseif is_unix then
  extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
  cmd = extension_path .. "adapter/codelldb"
elseif is_win32 then
  extension_path = vim.env.HOME .. "C:\\Users\\senhu\\.vscode\\extensions\\vadimcn.vscode-lldb-1.7.0\\"
  cmd = extension_path .. "adapter\\codelldb"
end

local dap = require("dap")

dap.adapters.codelldb = function(on_adapter)
  -- This asks the system for a free port
  local tcp = vim.loop.new_tcp()
  tcp:bind("127.0.0.1", 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()

  -- Start codelldb with the port
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local opts = {
    stdio = { nil, stdout, stderr },
    args = { "--port", tostring(port) },
  }
  local handle
  local pid_or_err
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  if not handle then
    vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
    stdout:close()
    stderr:close()
    return
  end
  vim.notify("codelldb started. pid=" .. pid_or_err)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  local adapter = {
    type = "server",
    host = "127.0.0.1",
    port = port
  }
  -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
  -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
  vim.defer_fn(function() on_adapter(adapter) end, 500)
end
