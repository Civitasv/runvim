-- Adjust the path to your executable
local is_unix = vim.fn.has("unix") == 1
local is_win32 = vim.fn.has("win32") == 1
local is_wsl = vim.fn.has("wsl") == 1
local extension_path
local cmd

if is_wsl then
  extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.8.1/"
  cmd = extension_path .. "adapter/codelldb"
elseif is_unix then
  extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
  cmd = extension_path .. "adapter/codelldb"
elseif is_win32 then
  extension_path = vim.env.HOME .. "C:\\Users\\senhu\\.vscode\\extensions\\vadimcn.vscode-lldb-1.8.1\\"
  cmd = extension_path .. "adapter\\codelldb"
end

local dap = require("dap")

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = cmd,
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
