## Require

- Neovim >= 0.12.0
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) (required by nvim-treesitter `main` to compile parsers; `brew install tree-sitter-cli`)
- [nerd-fonts](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-installation)
- [terraform-ls](https://github.com/hashicorp/terraform-ls/blob/main/docs/installation.md)
- [fd](https://github.com/sharkdp/fd?tab=readme-ov-file#installation)

## Recommend

- [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
  - Necessary to use `live_grep` of telescope.nvim

## Usage

### Git Clone

```sh
cd ~/.config
git clone git@github.com:walkersumida/nvim.git
```

### Starting Neovim

```sh
nvim
```

### Confirm Linters

After starting Neovim, check the linters with the following command. Install linters as needed.

```sh
:ConformInfo
```

## Included Plugins

TODO

## Key Mappings

TODO
