local file = require("user.utils.file")
local dap = require('dap')

local is_unix = vim.fn.has("unix")
local is_win32 = vim.fn.has("win32")

if is_unix then
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/civitasv/.config/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7'
  }
elseif is_win32 then
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '~/AppData/Local/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7.exe',
    options = {
      detached = false
    }
  }
end

dap.configurations.c = {
  {
    name = "C Debug And Run",
    type = "cppdbg",
    request = "launch",
    program = function ()
      local fileName = vim.fn.expand('%:t:r')
      if(not file.exists("bin")) then
        -- create this directory
        os.execute("mkdir " .. "bin")
      end
      local cmd = "!gcc -g % -o bin/" .. fileName
      -- First, compile it
      vim.cmd(cmd)
      -- Then, return it
      return '${fileDirname}/bin/' .. fileName
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false
      },
    },
  },
}

