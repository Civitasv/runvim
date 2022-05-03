local file = require("user.utils.file")
local dap = require('dap')

dap.configurations.cpp = {
  {
    name = "C++ Debug And Run",
    type = "codelldb",
    request = "launch",
    program = function ()
      -- First, check if exists CMakeLists.txt
      if(file.exists("CMakeLists.txt"))then
        -- Then invoke cmake commands
        local cwd = vim.fn.getcwd()
        vim.cmd("CMakeOpen")

      else
        local fileName = vim.fn.expand('%:t:r')
        if(not file.exists("bin")) then
          -- create this directory
          os.execute("mkdir " .. "bin")
        end
        local cmd = "!g++ -g % -o bin/" .. fileName
        -- First, compile it
        vim.cmd(cmd)
        -- Then, return it
        return '${fileDirname}/bin/' .. fileName
      end
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true
  },
}

