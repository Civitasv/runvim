return {
  "kylechui/nvim-surround", -- Surround
  config = function()
    local surround = require("nvim-surround")

    surround.setup({
      keymaps = { -- vim-surround style keymaps
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
}
