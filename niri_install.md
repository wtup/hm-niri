# steps

/> [!WARNING]
> read for more info <https://yalter.github.io/niri/Getting-Started.html>
> and <https://yalter.github.io/niri/Example-systemd-Setup.html>

1. Install mako, waybar, swaybg and swayidle swaylock

  ``` bash
  sudo apt install -y mako-notifier swaybg swayidle swaylock
  ```

1. Swaybg uses service file from nirisexample systemd setup page

  `~/.config/systemd/user/swaybg.service`

  ```bash
  [Unit]
  PartOf=graphical-session.target
  After=graphical-session.target
  Requisite=graphical-session.target

  [Service]
  ExecStart=/usr/bin/swaybg -m fill -i "%h/Pictures/LakeSide.png"
  Restart=on-failure
  ```

1. Swayidle uses service file from nirisexample systemd setup page

  `~/.config/systemd/user/swayidle.service`

  ```bash
  [Unit]
  PartOf=graphical-session.target
  After=graphical-session.target
  Requisite=graphical-session.target

  [Service]
      ExecStart=/usr/bin/swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f'
  Restart=on-failure
  ```

1. swaylock uses service file from getting strated pages

1. Install waybar from nix for a newer version

  ``` bash
  nix profile add nixpgks:waybar
  ```

1. Install fuzzel from nix

``` bash
  nix profile add nixpgks:fuzzel
```

1. Install niri with cargo

  ``` bash
  cargo install --git https://github.com/YaLTeR/niri niri
  ```

  Install [xwayland-satellite](https://github.com/Supreeeme/xwayland-satellite)
  from source, because it is not available in apt.

1. Copy resource files in the git repo to correct paths

  ```bash
  git clone https://github.com/YaLTeR/niri
  ```

  From the resource folder copy the following:
  
  | File                                     | Destination                          |
  | ---                                      | ---                                  |
  | target/release/niri                      | /usr/local/bin/                      |
  | resources/niri-session                   | /usr/local/bin/                      |
  | resources/niri.desktop                   | /usr/local/share/wayland-sessions/   |
  | resources/niri-portals.conf              | /usr/local/share/xdg-desktop-portal/ |
  | resources/niri.service (systemd)         | /etc/systemd/user/                   |
  | resources/niri-shutdown.target (systemd) | /etc/systemd/user/                   |

  /> [!WARNING]
  > There is an error in the niri.service file: the binary is assumed to be located
  > in /usr/bin/ but according to the table we copied it to /usr/local/bin

1. Add wants mako to niri with
  NOTE: the service file is available only if you install with apt

  see getting started with niri for commands

  ```bash
  systemctl --user add-wants niri.service mako.service
  ```

1. configure mako

`$HOME/.config/mako/config`

``` bash
text-color=#cad3f5
background-color=#24273a
border-radius=10
```

1. To handle automatic screen configuration use kanshi

  ``` bash
  sudo apt install kanshi
  ```

  and to read the installed version config man pages use `man 5 kanshi`

  Configuration at time of writing:

  ``` bash
profile home_work {
  output "Samsung Display Corp. 0x419F Unknown" enable mode 2880x1800@120.000 position 0,0 scale 1.5

  output "HP Inc. HP X27q 6CM1330SHZ" enable mode 2560x1440@59.951 position 1920,0 scale 1

  output "Dell Inc. DELL P2419H 2TSDPD3" enable mode 1920x1080@60.000 position 4480,0 scale 1 transform 90
}
  ```

1. Swaylock

  Swaylock config `$HOME/.config/swaylock/config`

  ``` bash
  image=$HOME/Pictures/wallpapers/spiderverse.png
  ```

1. Use ashell as shell instead of waybar

  <https://github.com/MalpenZibo/ashell>
  Install it from source, with cargo.

  `$HOME/.config/ashell/config.toml`

  ```bash
  log_level = "warn"
  position = "Top"
  app_launcher_cmd = "fuzzel"

  [modules]
  left = [["appLauncher", "Updates", "Workspaces"]]
  center = ["WindowTitle"]
  right = ["SystemInfo", ["Tray", "Clock", "Privacy", "Settings"]]

  [updates]
  check_cmd = "apt update && apt list --upgradeable 2>/dev/null | tail -n +2"
  update_cmd = 'alacritty -e bash -c \"sudo apt update && sudo apt upgrade; echo Done - Press enter to exit; read\" &'

  [workspaces]
  enable_workspace_filling = true

  [[CustomModule]]
  name = "appLauncher"
  icon = "󱗼"
  command = "fuzzel"

  [window_title]
  truncate_title_after_length = 100

  [settings]
  lock_cmd = "playerctl --all-players pause; nixGL hyprlock &"
  audio_sinks_more_cmd = "pavucontrol -t 3"
  audio_sources_more_cmd = "pavucontrol -t 4"
  wifi_more_cmd = "nm-connection-editor"
  vpn_more_cmd = "nm-connection-editor"
  bluetooth_more_cmd = "blueberry"

  [appearance]
  style = "Islands"

  primary_color = "#7aa2f7"
  success_color = "#9ece6a"
  text_color = "#a9b1d6"
  workspace_colors = ["#7aa2f7", "#9ece6a"]
  special_workspace_colors = ["#7aa2f7", "#9ece6a"]

  [appearance.danger_color]
  base = "#f7768e"
  weak = "#e0af68"

  [appearance.background_color]
  base = "#1a1b26"
  weak = "#24273a"
  strong = "#414868"

  [appearance.secondary_color]
  base = "#0c0d14"
  ```
