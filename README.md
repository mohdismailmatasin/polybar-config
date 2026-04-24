# Polybar Configuration

![Polybar Sample](polybar-image.png)

My personal polybar configuration for Arch Linux/i3wm.

## Files

- `config.ini` - Main polybar configuration
- `cava.sh` - Cava audio visualizer script
- `bluetooth.sh` - Bluetooth status module
- `wifi.sh` - WiFi status module
- `toggle_wifi.sh` - WiFi toggle script
- `toggle_bluetooth.sh` - Bluetooth toggle script

## Requirements

- Polybar
- i3wm (or compatible window manager)
- NetworkManager
- Bluez (for Bluetooth)
- Cava (optional, for audio visualization)
- PulseAudio
- pavucontrol (for volume settings)
- tilix (terminal emulator)
- wiremix (CLI audio mixer for Connman)
- ttf-poppins-fonts (font)
- ttf-nerd-fonts-symbols (font)

## Installation

1. Copy the contents of this repository to `~/.config/polybar/`
2. Configure your window manager to launch polybar

```bash
polybar main -c ~/.config/polybar/config.ini
```