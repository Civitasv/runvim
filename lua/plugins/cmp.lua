return {
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
    "rcarriga/cmp-dap",
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
            or require("cmp_dap").is_dap_buffer()
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
}
