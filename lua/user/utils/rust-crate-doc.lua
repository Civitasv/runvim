local status_ok, crates = pcall(require, "crates")
if not status_ok then
  return
end

local function showRustCratesDocumentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  elseif vim.fn.expand("%:t") == "Cargo.toml" then
    crates.show_popup()
  else
    vim.lsp.buf.hover()
  end
end

return showRustCratesDocumentation
