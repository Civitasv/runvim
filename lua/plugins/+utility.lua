return {
  {
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  },
  {
    "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  },
  {
    "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
    config = function()
      -- Setup nvim-cmp.
      local npairs = require("nvim-autopairs")

      npairs.setup {
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      }

      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end
  },
  {
    "famiu/bufdelete.nvim",
    config = function()
    end
  },
  {
    "hrsh7th/nvim-cmp",           -- The completion plugin
    dependencies = {
      "hrsh7th/cmp-buffer",       -- buffer completions
      "hrsh7th/cmp-path",         -- path completions
      "hrsh7th/cmp-cmdline",      -- cmdline completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "hrsh7th/cmp-nvim-lsp",
      -- snippets
      "L3MON4D3/LuaSnip",             --snippet engine
      "rafamadriz/friendly-snippets", -- a bunch of snippets to use
    },
    config = function()
      local cmp = require("cmp")

      local luasnip = require("luasnip")

      local kind_icons = require("config.icons").kind

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()

      local cmp_style = "atom" -- either default, atom
      local field_arrangement = {
        default = { "abbr", "kind", "menu" },
        atom = { "kind", "abbr", "menu" },
      }
      local formatting_style = {
        -- default fields order i.e completion word + item.kind + item.kind icons
        fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

        format = function(_, item)
          local icon = (kind_icons[item.kind]) or ""

          if cmp_style == "atom" then
            icon = " " .. icon .. " "
            item.menu = "   (" .. item.kind .. ")"
            item.kind = icon
          else
            icon = (" " .. icon .. " ")
            item.kind = string.format("%s %s", icon, item.kind)
          end

          return item
        end,
      }
      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end
      -- find more here: https://www.nerdfonts.com/cheat-sheet

      cmp.setup {
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        end,
        view = {
          entries = "custom" -- can be "custom", "wildmenu" or "native"
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        },
        formatting = formatting_style,
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "crates" }
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        completion = {
          completeopt = "menu,menuone"
        },
        window = {
          completion =
          {
            scrollbar    = false,
            winhighlight = "Normal:Cmpmenu,FloatBorder:Cmpmenu,CursorLine:PmenuSel,Search:None",
            border       = border("CmpDocBorder"),
            side_padding = 0,
          },
          documentation = { winhighlight = "Normal:CmpDoc", border = border("CmpDocBorder") },
        }
      }

      -- Set configuration for git
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        })
      })
    end
  },
  {
    "CRAG666/code_runner.nvim",
    config = function()
      local code_runner = require("code_runner")

      code_runner.setup({
        mode = "term",
        startinsert = true,
        filetype = {
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          python = "python3 -u",
          typescript = "deno run",
          rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
          c = "cd $dir && mkdir -p bin && cd bin && gcc ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
          cpp = "cd $dir && mkdir -p bin && cd bin && g++ ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
          haskell = "ghc $fileName && ./$fileNameWithoutExt"
        },
        project = {}
      })
    end
  },
  {
    "numToStr/Comment.nvim", -- Easily comment stuff
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      vim.g.skip_ts_context_commentstring_module = true

      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end
  },
  {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
      position = "right",
      width = 60
    }
  },
  {
    "editorconfig/editorconfig-vim", -- editor config
    config = function()
      vim.cmd([[
      let g:EditorConfig_exclude_patterns = ['fugitive://.*']
    ]])
    end
  },
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {}
      }
    end
  },
  {
    "folke/neodev.nvim",
    config = function()
      local neodev = require("neodev")

      neodev.setup({

      })
    end
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      local ufo = require("ufo")

      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99 -- feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" > %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      ufo.setup({
        fold_virt_text_handler = handler,
        --[[ provider_selector = function(bufnr, filetype) ]]
        --[[   return { "treesitter", "indent" } ]]
        --[[ end ]]
      })
    end
  },
  {
    "kylechui/nvim-surround", -- Surround
    config = function()
      local surround = require("nvim-surround")

      surround.setup({
        keymaps = {
                    -- vim-surround style keymaps
          insert = "<C-g>s",
          normal = "ys",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
        },
        aliases = {
          ["a"] = ">", -- Single character aliases apply everywhere
          ["b"] = ")",
          ["B"] = "}",
          ["r"] = "]",
          ["q"] = { '"', "'", "`" }, -- Table aliases only apply for changes/deletions
        },
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },
    },
    config = function()
      local telescope = require("telescope")
      local icons = require("config.icons")
      local actions = require("telescope.actions")
      local trouble = require("trouble.providers.telescope")

      telescope.setup {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          prompt_prefix = icons.ui.Telescope,
          selection_caret = icons.ui.Fire,
          path_display = { "truncate" },
          winblend = 0,
          color_devicons = true,
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          border = {},
          borderchars = {
            { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          },
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-t>"] = trouble.open_with_trouble,
            },

            n = {
              ["<esc>"] = actions.close,
              ["q"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = trouble.open_with_trouble,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down
            },
          },
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
              width = 0.8,
              previewer = true,
              prompt_title = false,
              borderchars = {
                { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
              },
            }
          },
          fzf = {
            --[[
              | Token     | Match type                 | Description                          |
              | --------- | -------------------------- | ------------------------------------ |
              | `sbtrkt`  | fuzzy-match                | Items that match `sbtrkt`            |
              | `'wild`   | exact-match (quoted)       | Items that include `wild`            |
              | `^music`  | prefix-exact-match         | Items that start with `music`        |
              | `.mp3$`   | suffix-exact-match         | Items that end with `.mp3`           |
              | `!fire`   | inverse-exact-match        | Items that do not include `fire`     |
              | `!^music` | inverse-prefix-exact-match | Items that do not start with `music` |
              | `!.mp3$`  | inverse-suffix-exact-match | Items that do not end with `.mp3`    |
              ]]
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          themes = {},
          terms = {}
        },
        preview = {
        }
      }

      telescope.load_extension("fzf")
      telescope.load_extension("dap")
    end
  },
  {
    "folke/todo-comments.nvim", -- Todo comments
    config = function()
      local todo_comments = require("todo-comments")

      local icons = require "config.icons"

      local error_red = "#F44747"
      local warning_orange = "#ff8800"
      local info_yellow = "#FFCC66"
      local hint_blue = "#4FC1FF"
      local perf_purple = "#7C3AED"
      -- local note_green = '#10B981'

      todo_comments.setup {
        signs = true,      -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = icons.ui.Bug,                        -- icon used for the sign, and in search results
            color = error_red,                          -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = icons.ui.Check, color = hint_blue, alt = { "TIP" } },
          HACK = { icon = icons.ui.Fire, color = warning_orange },
          WARN = { icon = icons.diagnostics.Warning, color = warning_orange, alt = { "HINT", "HACK" } },
          PERF = { icon = icons.ui.Dashboard, color = perf_purple, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = icons.ui.Note, color = info_yellow, alt = { "INFO" } },
        },
        -- merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          multiline = true,
          multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
          multiline_context = 10,   -- extra lines that will be re-evaluated when changing a line
          before = "",              -- "fg" or "bg" or empty
          -- keyword = "wide",
          -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
          keyword = "fg",
          after = "fg",                    -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
          comments_only = true,            -- uses treesitter to match keywords in comments only
          max_line_len = 400,              -- ignore lines longer than this
          exclude = {},                    -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
          warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
          info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
          hint = { "LspDiagnosticsDefaultHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" }
        },

        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      }

      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })
    end
  },
  {
    "akinsho/toggleterm.nvim", -- terminal
    config = function()
      local toggleterm = require("toggleterm")

      toggleterm.setup({
        size = 10,
        open_mapping = [[<c-t>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "single",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local node = Terminal:new({ cmd = "node", hidden = true })

      function _NODE_TOGGLE()
        node:toggle()
      end

      local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

      function _NCDU_TOGGLE()
        ncdu:toggle()
      end

      local htop = Terminal:new({ cmd = "htop", hidden = true })

      function _HTOP_TOGGLE()
        htop:toggle()
      end

      local python = Terminal:new({ cmd = "python", hidden = true })

      function _PYTHON_TOGGLE()
        python:toggle()
      end

      local glow = {
        term = nil,
        id = nil
      }
      glow.term = Terminal:new({
        hidden = true,
        float_opts = { border = "double" },
        on_exit = function(t)
          glow.id = nil
        end
      })
      function _GLOW_TOGGLE()
        local file = vim.fn.expand("%")
        glow.term:toggle()
        glow.term:send("glow " .. file .. " -p")
        glow.id = glow.term.job_id
      end
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      require "nvim-treesitter.install".compilers = { "clang" }

      configs.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "lua", "cpp", "bash", "bibtex", "clojure", "css", "gitignore", "gitcommit", "git_rebase", "gitattributes", "json", "python", "scss", "scheme", "sql", "toml", "typescript", "yaml", "rust", "vue", "javascript", "markdown", "markdown_inline", "haskell", "tsx", "vimdoc" },
        auto_install = false,
        sync_install = false,                  -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "hack", "rnoweb" }, -- List of parsers to ignore installing
        autopairs = {
          enable = true,
        },
        highlight = {
          enable = true,    -- false will disable the whole extension
          disable = { "" }, -- list of language that will be disabled
          additional_vim_regex_highlighting = true,
        },
        indent = { enable = true, disable = { "yaml" } },
      }
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      position = "bottom",            -- position of the list can be: bottom, top, left, right
      height = 10,                    -- height of the trouble list when position is top or bottom
      width = 50,                     -- width of the list when position is left or right
      icons = true,                   -- use devicons for filenames
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      severity = nil,                 -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
      fold_open = "",              -- icon used for open folds
      fold_closed = "",            -- icon used for closed folds
      group = true,                   -- group results by file
      padding = true,                 -- add an extra new line on top of the list
      cycle_results = true,           -- cycle item list when reaching beginning or end of list
      action_keys = {
                                      -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q",                                                                        -- close the list
        cancel = "<esc>",                                                                   -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r",                                                                      -- manually refresh
        jump = { "<cr>", "<tab>", "<2-leftmouse>" },                                        -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" },                                                           -- open buffer in new split
        open_vsplit = { "<c-v>" },                                                          -- open buffer in new vsplit
        open_tab = { "<c-t>" },                                                             -- open buffer in new tab
        jump_close = { "o" },                                                               -- jump to the diagnostic and close the list
        toggle_mode = "m",                                                                  -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s",                                                              -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P",                                                               -- toggle auto_preview
        hover = "K",                                                                        -- opens a small popup with the full multiline message
        preview = "p",                                                                      -- preview the diagnostic location
        open_code_href = "c",                                                               -- if present, open a URI with more information about the diagnostic error
        close_folds = { "zM", "zm" },                                                       -- close all folds
        open_folds = { "zR", "zr" },                                                        -- open all folds
        toggle_fold = { "zA", "za" },                                                       -- toggle fold of current file
        previous = "k",                                                                     -- previous item
        next = "j",                                                                         -- next item
        help = "?",                                                                         -- help menu
      },
      multiline = true,                                                                     -- render multi-line messages
      indent_lines = true,                                                                  -- add an indent guide below the fold icons
      win_config = { border = "single" },                                                   -- window configuration for floating windows. See |nvim_open_win()|.
      auto_open = false,                                                                    -- automatically open the list when you have diagnostics
      auto_close = false,                                                                   -- automatically close the list when you have no diagnostics
      auto_preview = true,                                                                  -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false,                                                                    -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" },                                                    -- for the given modes, automatically jump if there is only a single result
      include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
      signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",
      },
      use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    },
  },
  {
    "folke/which-key.nvim", -- vim which key
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local which_key = require("which-key")

      which_key.setup({
        plugins = {
          spelling = false
        },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false
        },
        window = {
          border = "single"
        }
      })
      which_key.register({
        mode = { "n" },
        ["<leader>b"] = { name = "+buffers" },
        ["<leader>c"] = { name = "+cmake" },
        ["<leader>d"] = { name = "+debug" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>l"] = { name = "+lsp" },
        ["<leader>m"] = { name = "+markdown" },
        ["<leader>r"] = { name = "+code_runner" },
        ["<leader>t"] = { name = "+terminal" },
        ["<leader>x"] = { name = "+trouble" },
      })
    end
  }
}
