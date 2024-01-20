return {
  dir = "~/.local/share/nvim/personal/cmake-tools.nvim",
  dependencies = {
    "stevearc/overseer.nvim",
  },
  lazy = true,
  config = function()
    require("overseer").setup({
      task_list = {
        direction = "right",
        bindings = {
          ["?"] = "ShowHelp",
          ["g?"] = "ShowHelp",
          ["<CR>"] = "RunAction",
          ["<C-e>"] = "Edit",
          ["o"] = "Open",
          ["<C-v>"] = "OpenVsplit",
          ["<C-s>"] = "OpenSplit",
          ["<C-f>"] = "OpenFloat",
          ["<C-q>"] = "OpenQuickFix",
          ["p"] = "TogglePreview",
          ["<C-l>"] = false,
          ["<C-h>"] = false,
          ["<A-l>"] = "IncreaseDetail",
          ["<A-h>"] = "DecreaseDetail",
          ["L"] = "IncreaseAllDetail",
          ["H"] = "DecreaseAllDetail",
          ["["] = "DecreaseWidth",
          ["]"] = "IncreaseWidth",
          ["{"] = "PrevTask",
          ["}"] = "NextTask",
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          ["<A-k>"] = "ScrollOutputUp",
          ["<A-j>"] = "ScrollOutputDown",
          ["q"] = "Close",
        },
      }
    })
    require("cmake-tools").setup({
      cmake_command = "cmake",                                                           -- this is used to specify cmake command path
      ctest_command = "ctest",
      cmake_regenerate_on_save = true,                                                   -- auto generate when save CMakeLists.txt
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },                  -- this will be passed when invoke `CMakeGenerate`
      cmake_build_options = { "-j4" },                                                   -- this will be passed when invoke `CMakeBuild`
      cmake_build_directory = "out/${variant:buildType}",                                -- this is used to specify generate directory for cmake
      cmake_soft_link_compile_commands = false,                                          -- this will automatically make a soft link from compile commands file to project root dir
      cmake_compile_commands_from_lsp = true,                                            -- this will automatically set compile commands file location using lsp, to use it, please set `cmake_soft_link_compile_commands` to false
      cmake_kits_path = "/Users/civitasv/.local/share/CMakeTools/cmake-tools-kits.json", -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
      cmake_variants_message = {
        short = { show = true },                                                         -- whether to show short message
        long = { show = true, max_length = 40 },                                         -- whether to show long message
      },
      cmake_dap_configuration = {                                                        -- debug settings for cmake
        name = "cpp",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
      },
      cmake_executor = {             -- executor to use
        name = "quickfix",           -- name of the executor
        opts = {},                   -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
        default_opts = {             -- a list of default and possible values for executors
          quickfix = {
            show = "always",         -- "always", "only_on_error"
            position = "belowright", -- "bottom", "top"
            size = 10,
          },
          overseer = {
            new_task_opts = {
              strategy = {
                "toggleterm",
                direction = "horizontal",
                autos_croll = true,
                quit_on_exit = "success"
              }
            },   -- options to pass into the `overseer.new_task` command
            on_new_task = function(task)
            end, -- a function that gets overseer.Task when it is created, before calling `task:start`
          },
          terminal = {
            name = "Main Terminal",
            prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = "horizontal", -- "horizontal", "vertical"
            split_size = 11,

            -- Window handling
            single_terminal_per_instance = true,  -- Single viewport, multiple windows
            single_terminal_per_tab = true,       -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

            -- Running Tasks
            start_insert = false,       -- If you want to enter terminal with :startinsert
            focus = false,              -- Focus on cmake terminal when cmake task is launched.
            do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
          },                            -- terminal executor uses the values in cmake_terminal
        },
      },
      cmake_runner = {               -- runner to use
        name = "overseer",           -- name of the runner
        opts = {},                   -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
        default_opts = {             -- a list of default and possible values for runners
          quickfix = {
            show = "always",         -- "always", "only_on_error"
            position = "belowright", -- "bottom", "top"
            size = 10,
            encoding = "utf-8",
            auto_close_when_success = false, -- typically, you can use it with the "always" option; it will auto-close the quickfix buffer if the execution is successful.
          },
          overseer = {
            new_task_opts = {
              strategy = {
                "toggleterm",
                direction = "float",
                autos_croll = true
              }
            },                                -- options to pass into the `overseer.new_task` command
            on_new_task = function(task) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
          },
          terminal = {
            name = "Runner Terminal",
            prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
            split_direction = "horizontal", -- "horizontal", "vertical"
            split_size = 10,

            -- Window handling
            single_terminal_per_instance = true,  -- Single viewport, multiple windows
            single_terminal_per_tab = true,       -- Single viewport per tab
            keep_terminal_static_location = true, -- Static location of the viewport if avialable

            -- Running Tasks
            start_insert = true,        -- If you want to enter terminal with :startinsert
            focus = true,               -- Focus on cmake terminal when cmake task is launched.
            do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
          },
        },
      },
      cmake_notifications = {
        runner = { enabled = true },
        executor = { enabled = true },
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
        refresh_rate_ms = 100, -- how often to iterate icons
      },
    })
  end
}
