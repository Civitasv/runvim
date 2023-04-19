# RuNvim(simple version)

> It's **runvim**, not run vim, but **ru**n **N**eo**vim**.  
> Notes: it's a simple configuration, without lsp, without debug, without treesitter.   
> It's simply just used to edit files.  
> For users who want be more powerful, checkout master.  
> But for users who want be most powerful, please bear with me using this branch.

* [Showcase](#showcase)
* [Installation](#installation)
  * [Pre-requisites](#pre-requisites)
  * [For Unix](#for-unix)
  * [For Windows](#for-windows)
* [Timeline](#timeline)


## Showcase

![alpha](images/alpha.png)

![search](images/search.png)

![terminal](images/terminal.png)

![whichkey](images/whichkey.png)

![diffview](images/diffview.png)

> note: right side is current version, left side is compared version.

**Now you can compare file with any older commit:**

![compare file with any older commit](images/file_history.gif)

**And you even can compare older version file with any older version file:**

![ex](images/older_file_diff.gif)

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

- 2023-04-19: initial this configuration
