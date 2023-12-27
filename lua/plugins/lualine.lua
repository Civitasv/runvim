return {
  "nvim-lualine/lualine.nvim", -- status line
  config = function()
    local lualine = require("lualine")

    local cmake = require("cmake-tools")

    -- Credited to [evil_lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- stylua: ignore start
    local colors = {
      normal = {
        bg       = "#202328",
        fg       = "#bbc2cf",
        yellow   = "#ECBE7B",
        cyan     = "#008080",
        darkblue = "#081633",
        green    = "#98be65",
        orange   = "#FF8800",
        violet   = "#a9a1e1",
        magenta  = "#c678dd",
        blue     = "#51afef",
        red      = "#ec5f67",
      },
      nightfly = {
        bg       = "#2e3440",
        fg       = "#cbced2",
        yellow   = "#ecc48d",
        cyan     = "#7fdbca",
        darkblue = "#82aaff",
        green    = "#21c7a8",
        orange   = "#e3d18a",
        violet   = "#a9a1e1",
        magenta  = "#ae81ff",
        blue     = "#82aaff	",
        red      = "#ff5874",
      },
      kanagawa = {
        bg       = "#16161D",
        fg       = "#C8C093",
        yellow   = "#ecc48d",
        cyan     = "#7fdbca",
        darkblue = "#82aaff",
        green    = "#21c7a8",
        orange   = "#e3d18a",
        violet   = "#a9a1e1",
        magenta  = "#ae81ff",
        blue     = "#82aaff	",
        red      = "#ff5874",
      },
      light = {
        bg       = "#f6f2ee",
        fg       = "#3d2b5a",
        yellow   = "#ac5402",
        cyan     = "#287980",
        darkblue = "#2848a9",
        green    = "#396847",
        orange   = "#a5222f",
        violet   = "#8452d5",
        magenta  = "#6e33ce",
        blue     = "#2848a9",
        red      = "#b3434e",
      },
      catppuccin_mocha = {
        bg       = "#1E1E2E",
        fg       = "#CDD6F4",
        yellow   = "#F9E2AF",
        cyan     = "#7fdbca",
        darkblue = "#89B4FA",
        green    = "#A6E3A1",
        orange   = "#e3d18a",
        violet   = "#a9a1e1",
        magenta  = "#ae81ff",
        blue     = "#89B4FA",
        red      = "#F38BA8",
      }
    }

    colors = colors.kanagawa;

    local config = {
      options = {
        icons_enabled = true,
        component_separators = "",
        section_separators = "",
        disabled_filetypes = { "alpha", "dashboard", "Outline" },
        always_divide_middle = true,
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- c for left
        lualine_c = {},
        -- x for right
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
      tabline = {},
      extensions = {},
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      -- mode component
      "mode",
      color = function()
        -- auto change color according to neovims mode
        return { bg = colors.fg, fg = colors.bg }
      end,
      padding = { right = 1, left = 1 },
    }

    ins_left {
      "filename",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.fg, gui = "bold" },
    }

    ins_left {
      "o:encoding",       -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.fg, gui = "bold" },
    }

    ins_left {
      function()
        local c_preset = cmake.get_configure_preset()
        return "CMake: [" .. (c_preset and c_preset or "X") .. "]"
      end,
      cond = function()
        return cmake.is_cmake_project() and cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectConfigurePreset")
          end
        end
      end
    }

    ins_left {
      function()
        local type = cmake.get_build_type()
        return "CMake: [" .. (type and type or "") .. "]"
      end,
      cond = function()
        return cmake.is_cmake_project() and not cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectBuildType")
          end
        end
      end
    }

    ins_left {
      function()
        local kit = cmake.get_kit()
        return "{" .. (kit and kit or "X") .. "}"
      end,
      cond = function()
        return cmake.is_cmake_project() and not cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectKit")
          end
        end
      end
    }

    ins_left {
      function()
        local b_preset = cmake.get_build_preset()
        return "[" .. (b_preset and b_preset or "X") .. "]"
      end,
      cond = function()
        return cmake.is_cmake_project() and cmake.has_cmake_preset()
      end,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectBuildPreset")
          end
        end
      end
    }

    ins_left {
      function()
        local b_target = cmake.get_build_target()
        return "<" .. (b_target and b_target or "X") .. ">"
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectBuildTarget")
          end
        end
      end
    }

    ins_left {
      function()
        local l_target = cmake.get_launch_target()
        return "(" .. (l_target and l_target or "X") .. ")"
      end,
      cond = cmake.is_cmake_project,
      on_click = function(n, mouse)
        if (n == 1) then
          if (mouse == "l") then
            vim.cmd("CMakeSelectLaunchTarget")
          end
        end
      end
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return "%="
      end,
    }

    ins_right {
      "searchcount"
    }

    -- Add components to right sections
    ins_right {
      function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end,
      color = { fg = colors.fg, gui = "bold" }
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end
}
