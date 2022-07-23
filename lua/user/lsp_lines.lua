local status_ok, lsp_lines = pcall(require, "lsp_lines")
if not status_ok then
  return
end

lsp_lines.setup()

vim.keymap.set("n", "g?", function()
  local lines_enabled = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config(
    {
      virtual_lines = lines_enabled,
      virtual_text = not lines_enabled
    }
  )
end, { noremap = true, silent = true })

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false
})
