local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local keymap_restore = {}
dap.listeners.after["event_initialized"]["me"] = function()
  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
    for _, keymap in pairs(keymaps) do
      if keymap.lhs == "K" then
        table.insert(keymap_restore, keymap)
        vim.api.nvim_buf_del_keymap(buf, "n", "K")
      end
    end
  end
  vim.keymap.set("n", "K", function() require("dap.ui.widgets").hover() end, { silent = true })
end

dap.listeners.after["event_terminated"]["me"] = function()
  for _, keymap in pairs(keymap_restore) do
    vim.api.nvim_buf_set_keymap(
      keymap.buffer,
      keymap.mode,
      keymap.lhs,
      keymap.rhs,
      { silent = keymap.silent == 1 }
    )
  end
  keymap_restore = {}
end

dap.set_exception_breakpoints("default")

local dap_virtual_text_status_ok, dap_virtual_text_status = pcall(require, "nvim-dap-virtual-text")
if not dap_virtual_text_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

dap_virtual_text_status.setup({
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = true, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

dapui.setup({
  layouts = {
    {
      elements = {
        "watches",
      },
      size = 0.2,
      position = "left",
    },
  },
  controls = {
    enabled = false,
  },
  render = {
    max_value_lines = 3,
  },
})

local icons = require("user.icons")
vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
vim.fn.sign_define("DapBreakpoint", { text = icons.ui.TinyCircle, texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = icons.ui.CircleWithGap, texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = icons.ui.LogPoint, texthl = "Error", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = icons.ui.ChevronRight, texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = icons.diagnostics.Error, texthl = "Error", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("user.daps.adapter.lldb")

require("user.daps.settings.cpp")
require("user.daps.settings.c")
