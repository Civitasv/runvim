local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/civitasv/文档/workflow/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
  {
    name = "C++ Debug And Run",
    type = "cppdbg",
    request = "launch",
    program = function ()
      local fileName = vim.fn.expand('%:r')
      if(not exists("bin")) then
        -- create this directory
        os.execute("mkdir " .. "bin")
      end
      local cmd = "!g++ -g % -o bin/" .. fileName
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

--- Check if a file or directory exists in this path
function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists in this path
function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
end
