# Polybar Configuration

![Polybar Sample](polybar-image.png)

My personal polybar configuration for Linux with i3wm.

## Files

- `config.ini` - Main polybar configuration
- `scripts/battery.sh` - Battery status module
- `scripts/cpu.sh` - CPU usage module
- `scripts/memory.sh` - Memory usage module
- `scripts/temperature.sh` - CPU temperature module
- `scripts/volume.sh` - Volume control module
- `scripts/power.sh` - Power menu script
- `scripts/cava.sh` - Cava audio visualizer module
- `scripts/bluetooth.sh` - Bluetooth status module
- `scripts/wifi.sh` - WiFi status module
- `scripts/toggle_wifi.sh` - WiFi toggle script
- `scripts/toggle_bluetooth.sh` - Bluetooth toggle script

## Requirements

- Polybar
- i3wm (or compatible window manager)
- pamixer (PulseAudio volume control)
- Bluez (for Bluetooth)
- Cava (optional, for audio visualization)
- Connman (network manager)
- impala (Connman CLI)
- bluetui (Bluetooth TUI)
- tilix (terminal emulator)
- JetBrains Mono Nerd Font

## Installation

1. Copy the contents of this repository to `~/.config/polybar/`
2. Configure your window manager to launch polybar:

```bash
polybar main -c ~/.config/polybar/config.ini
```

## Modules

| Module | Description |
|--------|-------------|
| xworkspaces | i3 workspace indicators |
| memory | RAM usage |
| cpu | CPU usage |
| temperature | CPU temperature |
| battery | Battery status |
| power | Power menu (click for shutdown menu) |
| cava | Audio visualizer |
| volume | Volume control (click to toggle, scroll to adjust, right-click to open wiremix) |
| wlan | WiFi status (click to toggle, right-click to open impala) |
| bluetooth | Bluetooth status (click to toggle, right-click to open bluetui) |
| date | Date and time |