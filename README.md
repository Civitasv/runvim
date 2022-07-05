# Neovim Config

> Neovim is a Vim-based text editor engineered for extensibility and usability.

## Why I Quit Emacs

I've tried Emacs, just because I think lisp is really elegant, but after some work, I think it's not cleaner than neovim, I know it's so powerful, has so many features, however, I don't think it's really useful. I don't get org-mode, don't use it to listen music, play games.

And I find Neovim really meet my needs and my workflow, So, I will just stick to Neovim.

## Timeline

- 2022-06-18:

  - Lsp Stuff
  - Dap Stuff
  - Treesitter
  - More modern neovim features

- 2022-05-04:
  - Rewrite configuration in lua
  - It's more consistent and more useful
  - Telescope
  - Lsp
  - Dap
  - Treesitter
  - and more

## 为什么

1. Blazingly fast ⚡；
2. 支持几乎所有的 Vim 插件；
3. Built-in lua，目前支持使用 Lua 或 Vimscript 配置 Neovim；
4. 几乎完全修改了插件系统，目前几乎可以使用任何语言编写插件；
5. Builtin Lsp；
6. ....

## 个人配置展示

### 搜索

**搜索文字：**

![search words](images/search.gif)

**搜索文件**：

![search files](images/search_file.gif)

### 智能补全

![lsp](images/lsp.gif)

### Code Runner

![runner](images/runner.gif)

### Debugger

![debug](images/debug.gif)

### Motion

![htop](images/hop.gif)

## Git workflow

1. Basic Blame information: gitsigns
2. Complex Blame information: vim-fugitive
3. Stage, Commit, Push: vim-fugitive
4. Or, Another Beautiful Git integration: lazygit & toggleterm

## Latex workflow

1. `,ll`: compile
2. `,lv`: sync location of pdf reader
3. `Ctrl+Click Pdf`: sync location of neovim
4. `,lk`: stop compile
5. `,lc`: clear compile middle files
6. `[[, ]], [], ][`: move between section boundaries
7. `dsc, dse, ds$, dsd`: Delete the surrounding command, environment or delimiter
8. `csc, cse, cs$, csd`: Change the surrounding command, environment or delimiter
9. `tsc, tse`: Toggle starred command or environment
10. `ts$`: Toggle inline and displaymath
11. `tsd`: Toggle between e.g. () and \left(\right)
12. `tsf`: Toggle (inline) fractions
13. others, see: <https://github.com/lervag/vimtex#configuration>
