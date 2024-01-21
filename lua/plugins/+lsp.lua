return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local icons = require("config.icons")
      local lsp = require("utils.lsp")

      -- Basic Setup START --
      local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      vim.diagnostic.config(
        {
          -- disable virtual text
          virtual_text = { prefix = icons.ui.VirtualPrefix },
          -- show signs
          signs = {
            active = signs,
          },
          update_in_insert = true,
          underline = true,
          severity_sort = true,
          float = {
            focusable = false,
            style = "minimal",
            border = "single",
            source = "always",
            header = "",
            prefix = "",
          },
        }
      )
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single"
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
        focusable = true,
        relative = "cursor"
      })
      -- suppress error messages from lang servers
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.notify = function(msg, log_level)
        if msg:match "exit code" then
          return
        end
        if log_level == vim.log.levels.ERROR then
          vim.api.nvim_err_writeln(msg)
        else
          vim.api.nvim_echo({ { msg } }, true, {})
        end
      end

      -- Borders for LspInfo winodw
      local win = require "lspconfig.ui.windows"
      local _default_opts = win.default_opts

      win.default_opts = function(options)
        local opts = _default_opts(options)
        opts.border = "single"
        return opts
      end
      -- Basic Setup END --

      local regular_servers = {
        "prosemd_lsp",
        "cssls",
        "vuels",
        "tsserver",
        "texlab",
        "angularls",
        "eslint",
        "cmake"
      }

      for _, server in ipairs(regular_servers) do
        lspconfig[server].setup({
          on_attach = lsp.on_attach,
          capabilities = lsp.capabilities,
        })
      end

      lspconfig.lua_ls.setup({
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = "$VIMRUNTIME/lua",
            },
            diagnostics = {
              globals = { "vim" },
              neededFileStatus = {
                ["codestyle-check"] = "Any",
              },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
            format = {
              enable = true,
              -- Put format options here
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                quote_style = "double",
                max_line_length = "unset"
              },
            },
          },
        },
      })


      lspconfig.clangd.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        on_new_config = function(new_config, _)
          local status, cmake = pcall(require, "cmake-tools")
          if status then
            cmake.clangd_on_new_config(new_config)
          end
        end,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--suggest-missing-includes",
          "--completion-style=bundled",
          "--cross-file-rename",
          "--header-insertion=iwyu",
        },
      })
    end
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")

      local mason_lspconfig = require("mason-lspconfig")

      local all_servers = {
        -- "jsonls",
        "lua_ls",
        "clangd",
        "hls",
        "prosemd_lsp",
        "cssls",
        "rust_analyzer",
        "vuels",
        "tsserver",
        "texlab",
        "angularls",
        "eslint",
        "cmake"
      }

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = all_servers, -- will be installed by mason
        automatic_installation = false
      })
    end
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim", -- show diagnostics using virtual lines
    config = function()
      local lsp_lines = require("lsp_lines")

      lsp_lines.setup()

      vim.keymap.set("n", "g?", function()
        local lines_enabled = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config(
          {
            virtual_lines = lines_enabled,
            virtual_text = not lines_enabled
          }
        )
      end, { noremap = true, silent = true, desc = "Change diagnostics style" })

      vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = false
      })
    end
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "single"
        },
        preview = {
          lines_above = 0,
          lines_below = 10,
        },
        scroll_preview = {
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
        request_timeout = 2000,
        finder = {
          --percentage
          max_height = 0.5,
          keys = {
            jump_to = "p",
            edit = { "o", "<CR>" },
            vsplit = "s",
            split = "i",
            tabe = "t",
            tabnew = "r",
            quit = { "q", "<ESC>" },
            close_in_preview = "<ESC>"
          },
        },
        definition = {
          edit = "<C-c>o",
          vsplit = "<C-c>v",
          split = "<C-c>i",
          tabe = "<C-c>t",
          quit = "q",
          close = "<Esc>",
        },
        code_action = {
          num_shortcut = true,
          show_server_name = false,
          extend_gitsigns = true,
          keys = {
            -- string | table type
            quit = "<ESC>",
            exec = "<CR>",
          },
        },
        lightbulb = {
          enable = true,
          enable_in_insert = false,
          sign = false,
          sign_priority = 40,
          virtual_text = false,
        },
        diagnostic = {
          show_code_action = true,
          show_source = true,
          jump_num_shortcut = true,
          --1 is max
          max_width = 0.7,
          custom_fix = nil,
          custom_msg = nil,
          text_hl_follow = false,
          border_follow = true,
          keys = {
            exec_action = "o",
            quit = "q",
            go_action = "g"
          },
        },
        rename = {
          quit = "<C-c>",
          exec = "<CR>",
          mark = "x",
          confirm = "<CR>",
          in_select = true,
        },
        outline = {
          win_position = "right",
          win_with = "",
          win_width = 30,
          show_detail = true,
          auto_preview = true,
          auto_refresh = true,
          auto_close = true,
          custom_sort = nil,
          keys = {
            jump = "o",
            expand_collapse = "u",
            quit = "q",
          },
        },
        symbol_in_winbar = {
          enable = false,
          separator = " › ",
          hide_keyword = true,
          show_file = true,
          folder_level = 1,
          color_mode = false,
        },
      })
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  }
}
