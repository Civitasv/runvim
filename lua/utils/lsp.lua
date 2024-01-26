local M = {}

local function lsp_highlight_document(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local function lsp_keymaps(client, bufnr)
  local keymap = function(mode, key, action, desc)
    vim.keymap.set(mode, key, action, { buffer = bufnr, desc = desc })
  end

  -- Peek definition
  -- You can edit the file containing the definition in the floating window
  -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
  -- It also supports tagstack
  -- Use <C-t> to jump back
  keymap("n", "gD", vim.lsp.buf.declaration, "Goto declaration")

  -- Go to definition
  keymap("n", "gd", vim.lsp.buf.definition, "Go to definition")

  -- Diagnostic jump
  -- You can use <C-o> to jump back to your previous location
  keymap("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
  keymap("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")

  -- If you want to keep the hover window in the top right hand corner,
  -- you can pass the ++keep argument
  -- Note that if you use hover with ++keep, pressing this key again will
  -- close the hover window. If you want to jump to the hover window
  -- you should use the wincmd command "<C-w>w"

  keymap("n", "K", vim.lsp.buf.hover)

  if client.name == "clangd" then
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(client, bufnr)
  lsp_highlight_document(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local cmp_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

cmp_capabilities.textDocument.semanticHighlighting = true
cmp_capabilities.offsetEncoding = "utf-8"
cmp_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

M.capabilities = cmp_capabilities

return M
