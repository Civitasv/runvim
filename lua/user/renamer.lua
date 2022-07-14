local status_ok, renamer = pcall(require, "renamer")
if not status_ok then
  return
end

local mappings_utils = require("renamer.mappings.utils")
renamer.setup({
  -- The popup title, shown if `border` is true
  title = "Rename",
  -- The padding around the popup content
  padding = {
    top = 0,
    left = 0,
    bottom = 0,
    right = 0,
  },
  -- Whether or not to shown a border around the popup
  border = true,
  -- The characters which make up the border
  border_chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  -- Whether or not to highlight the current word references through LSP
  show_refs = true,
  -- The keymaps available while in the `renamer` buffer. The example below
  -- overrides the default values, but you can add others as well.
  mappings = {
    ["<c-i>"] = mappings_utils.set_cursor_to_start,
    ["<c-a>"] = mappings_utils.set_cursor_to_end,
    ["<c-e>"] = mappings_utils.set_cursor_to_word_end,
    ["<c-b>"] = mappings_utils.set_cursor_to_word_start,
    ["<c-c>"] = mappings_utils.clear_line,
    ["<c-u>"] = mappings_utils.undo,
    ["<c-r>"] = mappings_utils.redo,
  },
})

-- Temporally fix the rename problem
renamer._apply_workspace_edit = function(resp)
  local params = vim.lsp.util.make_position_params()
  local results_lsp, _ = vim.lsp.buf_request_sync(0,
    require "renamer.constants".strings.lsp_req_rename, params)
  local client_id = results_lsp and next(results_lsp) or nil
  local client = vim.lsp.get_client_by_id(client_id)
  require "vim.lsp.util".apply_workspace_edit(resp, client.offset_encoding)
end
