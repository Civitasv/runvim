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

## Timeline

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
