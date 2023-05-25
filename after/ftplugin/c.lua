local function linux_kernel()
  vim.opt.expandtab = false; -- convert tabs to spaces
  vim.opt.shiftwidth = 8; -- the number of spaces inserted for each indentation
  vim.opt.tabstop = 8; -- insert 2 spaces for a tab
end

local function google_cc()
  vim.opt.expandtab = true; -- convert tabs to spaces
  vim.opt.shiftwidth = 2; -- the number of spaces inserted for each indentation
  vim.opt.tabstop = 2; -- insert 2 spaces for a tab
end

local function change_style()
  -- check if it is a fugitive file
  vim.ui.select({ "google", "linux" }, {
    prompt = "Select code style",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice == "google" then
      google_cc()
    elseif choice == "linux" then
      linux_kernel()
    end
  end)
end

vim.keymap.set({ "n" }, "<leader>ss", change_style, { silent = true, desc = "step out" })
