return {
  dir = "~/.local/share/nvim/personal/cmake-tools.nvim",
  config = function()
    require("cmake-tools").setup({
      cmake_command = "cmake",
      cmake_build_directory = "",
      cmake_build_directory_prefix = "build/",
      cmake_build_type = "Debug",
      cmake_soft_link_compile_commands = true,
      cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options = {},
      cmake_console_size = 10, -- cmake output window height
      cmake_show_console = "always", -- "always", "only_on_error"
      cmake_console_position = "belowright", -- "belowright", "aboveleft", ...
      cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_length = 40 }
      },
      cmake_dap_configuration = {
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      }, -- dap configuration, optional
    })
  end
}

