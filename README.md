# neovim-config

- installing some prerequisites

```
sudo apt install wget fontconfig
sudo apt install nodejs
sudo apt install ripgrep
sudo apt install unzip
sudo apt install xclip
sudo apt install python3-debugpy
sudo apt install fd-find
sudo apt install magic
sudo apt install luarocks
#install npm if it is not installed
# in ubuntu 24.04 sudo apt install -y python3-venv

####sudo apt install  luarocks lua5.1 ##only needed by rest-vim it is deprecated
#### also for this plugin we need in telescope.lua
######		telescope.load_extension("rest")

- install lazygit https://github.com/jesseduffield/lazygit/releases
- install golangci-lint go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.57.2

wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
cd ~/.local/share/fonts && unzip Meslo.zip && rm *Windows* && rm Meslo.zip && fc-cache -fv
sudo apt install unzip
cd ~/.local/share/fonts && unzip Meslo.zip && rm *Windows* && rm Meslo.zip && fc-cache -fv

##adding copilot
git clone https://github.com/github/copilot.vim.git \
  ~/.config/nvim/pack/github/start/copilot.vim

```

- one very good start is https://www.josean.com/posts/how-to-setup-neovim-2024

- to install

```

mv ~/.config/nvim{,.bak}
# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/dkr290/neovim-config.git   ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim
```

- comments
  (gc +G) all the text
  (gc +3j) or (gc +2j) depends how many lines to comment out
  (gc +c) only current line
- Open Mason or Lazy UI
  :Lazy or :Mason , LspInfo for the lsp server
  for Mason to install i to delete upper X
- <CTRL +o> or <CTRL +i> jump backwords or forwards
- for the todo comment
  type TODO or HACK or BUG with ESCP +: then type text and navigate with "[t" or "t]"
- substitution
  type for the text (v + w) to select it + (y copy)
  1. select word and (s + iw) - replace thw word
  2. same but select some parts and (s+$) replace to the end of the line
  3. s + G - substitute everything to the end of the file
  4. only ss or S for line or only to the end of the line
  5. in visual move v +l couple of times + s it will replace selected
- surround plugin
  ( y + s) to surround the text + motion (i + w) + ""

### some command for health check

```
:ConformInfo
:LspInfo
:checkhealth
:checkhealth vim.lsp
```
