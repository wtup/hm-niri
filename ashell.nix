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
    home_main_w = 2560; # HP X27q
    work_main_w = 2560; # BenQ PD3200Q
    home_main_pos = laptop_w;
    home_sec_pos = laptop_w + home_main_w;
    work_main_pos = laptop_w;
    work_sec_pos = laptop_w + work_main_w;
  in
''
    profile work_home {
      output "Samsung Display Corp. 0x419F Unknown" enable mode 2880x1800@60.000 position 0,0 scale 1.5

      output "HP Inc. HP X27q 6CM1330SHZ" enable mode 2560x1440@59.951 position ${toString home_main_pos},0 scale 1

      output "Dell Inc. DELL P2419H 2TSDPD3" enable mode 1920x1080@60.000 position ${toString home_sec_pos},0 scale 1 transform 90
    }
    profile laptop {
      output "Samsung Display Corp. 0x419F Unknown" enable mode 2880x1800@60.000 position 0,0 scale 1.5
    }
    profile work_office {
      output "Samsung Display Corp. 0x419F Unknown" enable mode 2880x1800@60.000 position 0,0 scale 1.5

      output "PNP(BNQ) BenQ PD3200Q 36M00548019" enable mode 2560x1440@59.951 position ${toString work_main_pos},0 scale 1

      output "Dell Inc. DELL P2419H 48TBPD3" enable mode 1920x1080@60.000 position ${toString work_sec_pos},0 scale 1 transform 270
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
  lock_cmd = "playerctl --all-players pause; swaylock"
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
  '';
}

