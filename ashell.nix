{config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ashell
    swaybg
    swayidle
    fuzzel
    mako
    kanshi
  ];

  programs.niri.settings.binds =
  {
    "Mod+D" = { action.spawn = ["fuzzel"]; hotkey-overlay.title = "Run an Application"; };
    "Mod+Shift+N" = {action.spawn = ["makoctl" "dismiss"]; };
    "Mod+Ctrl+N" = {action.spawn = ["makoctl" "restore"]; };
  };

  programs.niri.settings.spawn-at-startup = [
    { argv = ["ashell"]; }
  ];

  # Swaybg
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Service for managing background image.";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite=["graphical-session.target"];
    };
    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      ExecStart=''${pkgs.swaybg}/bin/swaybg -m fill -i "${config.xdg.configHome}/home-manager/walls/spiderverse.png"'';
      Restart="on-failure";
    };
  };

  # Swaylock
  xdg.configFile."swaylock/config".text = ''
  image=${config.xdg.configHome}/home-manager/walls/spiderverse.png
  '';

  # Swayidle
  systemd.user.services.swayidle = {
    Unit = {
      Description = "Service for managing idle lock.";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite=["graphical-session.target"];
    };
    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      ExecStart=''
        ${pkgs.swayidle}/bin/swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f'
      '';
      Restart="on-failure";
    };
  };

  # Mako
  xdg.configFile."mako/config".text = let
    colors = config.lib.stylix.colors;
  in ''
    default-timeout=5000

    text-color=#${colors.base05}
    background-color=#${colors.base00}
    border-color=#${colors.base0D}
    border-radius=10
  '';

  systemd.user.services.mako = {
    Unit = {
      Description = "Mako - Notification daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite=["graphical-session.target"];
    };
    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      ExecStart="${pkgs.mako}/bin/mako";
      Restart="on-failure";
    };
  };
  
  # kanshi
  xdg.configFile."kanshi/config".text =
  let
    laptop_w = 1920; # 2880 / 1.5 scale
    laptop_name = "Samsung Display Corp. 0x419F Unknown";
    laptop_scale = "1.5";
    laptop_resolution = "2880x1800@60.000";
    home_main_w = 2560; # HP X27q
    home_main_name = "HP Inc. HP X27q 6CM1330SHZ";
    work_main_w = 3840; # Dell P3225QE
    work_main_name = "Dell Inc. DELL P3225QE B3MLLF4";
    home_main_pos = laptop_w;
    home_sec_pos = laptop_w + home_main_w;
    work_main_pos = laptop_w;
    work_sec_pos = laptop_w + work_main_w;
  in
''
    profile work_home {
      output "${laptop_name}" enable mode ${laptop_resolution} position 0,0 scale ${laptop_scale}

      output "${home_main_name}" enable mode 2560x1440@59.951 position ${toString home_main_pos},0 scale 1.

      output "Dell Inc. DELL P2419H 2TSDPD3" enable mode 1920x1080@60.000 position ${toString home_sec_pos},0 scale 1 transform 90
    }
    profile laptop {
      output "${laptop_name}" enable mode ${laptop_resolution} position 0,0 scale ${laptop_scale}
    }
    profile work_office {
      output "${laptop_name}" enable mode ${laptop_resolution} position 0,0 scale ${laptop_scale}
      output "${work_main_name}" enable mode 3840x2160@59.997 position ${toString work_main_pos},0 scale 1.2

      #output "PNP(BNQ) BenQ PD3200Q 36M00548019" enable mode 3840x2160@59.997 position ${toString work_main_pos},0 scale 1
      #output "PNP(BNQ) BenQ PD3200Q 36M00548019" enable mode 2560x1440@59.951 position ${toString work_main_pos},0 scale 1

    }
  '';

  systemd.user.services.kanshi = {
    Unit = {
      Description = "Kanshi - Display output manager";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite=["graphical-session.target"];
    };
    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      ExecStart="${pkgs.kanshi}/bin/kanshi";
      Restart="on-failure";
    };
  };

  xdg.configFile."ashell/config.toml".text = ''
  region = "sl-SI"
  [modules]
  left = [ [ "appLauncher", "Updates", "Workspaces" ] ]
  center = [ "WindowTitle", "MediaPlayer" ]
  right = [ "SystemInfo", "KeyboardLayout", [ "Tray", "Tempo", "Privacy", "Settings" ] ]

  [updates]
  check_cmd = "apt update && apt list --upgradeable 2>/dev/null | tail -n +2"
  update_cmd = 'alacritty -e bash -c \"sudo apt update && sudo apt upgrade; echo Done - Press enter to exit; read\" &'

  [workspaces]
  visibility_mode = "MonitorSpecific"           # "All" (default), "MonitorSpecific", "MonitorSpecificExclusive"
  group_by_monitor = true
  enable_workspace_filling = false  # (default)
  # disable_special_workspaces = false  # (default) set true to hide special workspaces
  # max_workspaces = 10               # (default: None) max number of workspaces when filling
  # workspace_names = ["1", "2", "3"] # (default: []) custom names for workspaces
  # enable_virtual_desktops = false   # (default) group workspaces into virtual desktops
  # invert_scroll_direction = "All"   # (default: None) "All", "Mouse", or "Trackpad"

  [[CustomModule]]
  name = "appLauncher"
  icon = "󱗼"
  command = "fuzzel"

  [window_title]
  truncate_title_after_length = 100

  [keyboard_layout]
  labels = {  "English (US)" = "EN", "Slovenian" = "SI" }
  #labels = {  "English (US)" = "🇺🇸", "Slovenian" = "🇸🇮" }


  [settings]
  lock_cmd = "playerctl --all-players pause; swaylock"
  audio_sinks_more_cmd = "pavucontrol -t 3"
  audio_sources_more_cmd = "pavucontrol -t 4"
  wifi_more_cmd = "nm-connection-editor"
  vpn_more_cmd = "nm-connection-editor"
  bluetooth_more_cmd = "blueman-manager"
  battery_format = "IconAndPercentage"  # (default), "Icon", "Percentage", "Time", "IconAndTime"
  # battery_hide_when_full = false  # (default)
  # peripheral_indicators = "All"   # (default) or { Specific = ["Keyboard", "Mouse", "Headphones", "Gamepad"] }
  peripheral_battery_format = "Icon"  # (default), "IconAndPercentage", "Percentage", etc.
  # peripheral_expanded_by_default = false  # (default)
  audio_indicator_format = "Icon"        # (default), "IconAndPercentage", "Percentage", etc.
  microphone_indicator_format = "Icon"   # (default)
  network_indicator_format = "Icon"      # (default)
  bluetooth_indicator_format = "Icon"    # (default)
  brightness_indicator_format = "Icon"   # (default)
  volume_step = 5    # (default) step size for IPC volume up/down, range 1..=50
  max_volume = 100   # (default) max volume level, range 1..=200 (>100 enables overdrive)
  # remove_airplane_btn = false   # (default) set true to hide airplane mode button
  # remove_idle_btn = false       # (default) set true to hide idle inhibitor button
  indicators = [ "IdleInhibitor", "PowerProfile", "Audio", "Microphone", "Bluetooth", "Network", "Vpn", "Battery", "Brightness" ]
  # indicators = [ "IdleInhibitor", "PowerProfile", "Audio", "Microphone", "Bluetooth", "Network", "Vpn",
  
  [osd]
  enabled = true
  timeout = 1500
  show_volume_percentage = true
  show_brightness_percentage = true

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
  '';
}

