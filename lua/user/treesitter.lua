local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

require "nvim-treesitter.install".compilers = { "clang" }

configs.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "cpp", "bash", "bibtex", "clojure", "cmake", "css", "gitignore", "gitcommit", "git_rebase", "gitattributes", "json", "python", "scss", "scheme", "sql", "toml", "typescript", "yaml", "vue" },
  auto_install = false,
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "hack", "rnoweb" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
