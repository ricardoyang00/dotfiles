# Dotfiles

My personal macOS dotfiles managed with GNU Stow.


## Installation

**Warning:** If you have existing `.zshrc`, `.p10k.zsh`, or `.wezterm.lua` files, GNU Stow will fail. Back them up or remove them before installation.

Clone this repository to your home directory:

```bash
git clone https://github.com/ricardoyang00/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Run the installation script:

```bash
chmod +x install.sh
./install.sh
```

After installation completes, restart your terminal for changes to take effect.


## Customization

### Powerlevel10k Theme
To reconfigure the Powerlevel10k prompt:
```bash
p10k configure
```


## License

Feel free to use and modify these dotfiles for your own setup.

