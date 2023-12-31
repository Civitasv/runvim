local M = {}

local osys = require("utils.osys")

local extension_path
local codelldb_path
local liblldb_path

if osys.iswsl then
  extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.8.1/"
  codelldb_path = extension_path .. "adapter/codelldb"
  liblldb_path = extension_path .. "lldb/lib/liblldb.so"
elseif osys.islinux then
  extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
  codelldb_path = extension_path .. "adapter/codelldb"
  liblldb_path = extension_path .. "lldb/lib/liblldb.so"
elseif osys.ismac then
  extension_path = vim.env.HOME .. "/.vscode-insiders/extensions/vadimcn.vscode-lldb-1.10.0/"
  codelldb_path = extension_path .. "adapter/codelldb"
  liblldb_path = extension_path .. "lldb/lib/liblldb.so"
elseif osys.iswin32 then
  extension_path = vim.env.HOME .. "C:\\Users\\senhu\\.vscode\\extensions\\vadimcn.vscode-lldb-1.8.1\\"
  codelldb_path = extension_path .. "adapter\\codelldb"
  liblldb_path = extension_path .. "lldb\\lib\\liblldb.so"
end

M.codelldb_path = codelldb_path
M.liblldb_path = liblldb_path

return M
