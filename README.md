# RuNvim

> It's **runvim**, not run vim, but **ru**n **N**eo**vim**.

## Showcase

![alpha](images/alpha.png)

![search](images/search.png)

![lsp](images/lsp.png)

![terminal](images/terminal.png)

![docs](images/docs.png)

![whichkey](images/whichkey.png)

## Installation

### Pre-requisites

1. Neovim version > 0.7.
2. A Nerd Font for your terminal.

### For Unix

```bash
git clone https://github.com/Civitasv/runvim ~/.config/nvim --depth 1 ; nvim
```

### For Windows

```bash
git clone https://github.com/Civitasv/runvim $HOME\AppData\Local\nvim --depth 1 ; nvim
```

## keymaps Documention

I've added documention for almost all keymaps in my configuration. See [keymaps](keymap.md).

## Timeline

- 2022-07-14:
 - Add keymaps docs, make it clearer and easier.
 - Add rust crates support.
- 2022-07-07:
  - Add support for LaTeX: vimtex
  - Add Code fold: nvim-ufo
  - Add motion: hop
  - Add autocommand for png, gif, pdf, etc
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

