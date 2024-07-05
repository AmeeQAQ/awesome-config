# My Awesome WM setup
Repo to upload the config files used in my Awesome WM setup. 

It features VIM-like keybinds for workspace traversal, as well as client selection, that work really well with my minimal split keyboard, a pleasing color palette inspired by [Catppuccin](https://catppuccin.com/) and retrowave, and a modern floating wibar setup that I think looks really great.

## Screenshots
![Empty desktop](https://i.imgur.com/EmkRoFj.png)
![Neofetch](https://i.imgur.com/GTpqmDl.png)
![Multiple clients](https://i.imgur.com/s94FA67.png)

## Setup
Most of this config will work out of the box except the scripts. You can download those (#SOON) or make your own. Simply create lua files in the same fashion I did for my own scripts and call them in `ui/bar.lua`. After that, just add them at the right side by calling the new variable. You can easily do this by replacing my own code.

In the third screenshot I'm using [ncspot](https://github.com/hrkfdn/ncspot) as my Spotify client, [Neovim](https://neovim.io/) as the text editor and [Kitty](https://sw.kovidgoyal.net/kitty/) with the Catppuccin theme as my terminal.

## Dependencies
- Kitty is set to be the default terminal.
- Neovim as the default text editor.
- [Picom](https://github.com/yshui/picom) as the compositor.
- [Flameshot](https://flameshot.org/) as the screenshotting tool.
- [PipeWire](https://gitlab.freedesktop.org/pipewire/pipewire) with the PulseAudio plugin for audio control.
