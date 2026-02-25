{config, pkgs, ... }:
{
  home.packages = [
    pkgs.fuzzel
    # FIXME: Currently, niri doesnt work with this from unstable
    # but building it from source is ok !?!?
    # git log --oneline: bc47ef5 (HEAD -> main, origin/main, origin/HEAD) deps: bump `xcb` to 1.7.0
    # pkgs.xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings.environment = {
      SSH_AUTH_SOCK = "/run/user/25984/gcr/ssh";
      XDG_CURRENT_DESKTOP = "GNOME";
    };
    settings.layout = {
      focus-ring.width = 4;
    };
    settings.switch-events.lid-close = { action.spawn = ["swaylock"];};
    settings.binds = let
      a = name: { action.${name} = []; };
      aw = name: arg: { action.${name} = arg; };
    in {
      #"Mod+D" = { action.spawn = ["fuzzel"]; hotkey-overlay.title = "Run an Application"; };

      "Mod+Shift+Slash" = a "show-hotkey-overlay";
      "Mod+T" = { action.spawn = ["alacritty"]; hotkey-overlay.title = "Open a Terminal"; };
      "Mod+Q" = a "close-window";
      "Mod+O" = (a "toggle-overview") // { repeat = false; };

      "Mod+Left" = a "focus-column-left";
      "Mod+Down" = a "focus-window-down";
      "Mod+Up" = a "focus-window-up";
      "Mod+Right" = a "focus-column-right";
      "Mod+H" = a "focus-column-left";
      "Mod+J" = a "focus-window-down";
      "Mod+K" = a "focus-window-up";
      "Mod+L" = a "focus-column-right";
      "Mod+Home" = a "focus-column-first";
      "Mod+End" = a "focus-column-last";

      "Mod+Ctrl+Left" = a "move-column-left";
      "Mod+Ctrl+Down" = a "move-window-down";
      "Mod+Ctrl+Up" = a "move-window-up";
      "Mod+Ctrl+Right" = a "move-column-right";
      "Mod+Ctrl+H" = a "move-column-left";
      "Mod+Ctrl+J" = a "move-window-down";
      "Mod+Ctrl+K" = a "move-window-up";
      "Mod+Ctrl+L" = a "move-column-right";
      "Mod+Ctrl+Home" = a "move-column-to-first";
      "Mod+Ctrl+End" = a "move-column-to-last";

      "Mod+Shift+Left" = a "focus-monitor-left";
      "Mod+Shift+Down" = a "focus-monitor-down";
      "Mod+Shift+Up" = a "focus-monitor-up";
      "Mod+Shift+Right" = a "focus-monitor-right";
      "Mod+Shift+H" = a "focus-monitor-left";
      "Mod+Shift+J" = a "focus-monitor-down";
      "Mod+Shift+K" = a "focus-monitor-up";
      "Mod+Shift+L" = a "focus-monitor-right";
      "Mod+Shift+Ctrl+Left" = a "move-column-to-monitor-left";
      "Mod+Shift+Ctrl+Down" = a "move-column-to-monitor-down";
      "Mod+Shift+Ctrl+Up" = a "move-column-to-monitor-up";
      "Mod+Shift+Ctrl+Right" = a "move-column-to-monitor-right";
      "Mod+Shift+Ctrl+H" = a "move-column-to-monitor-left";
      "Mod+Shift+Ctrl+J" = a "move-column-to-monitor-down";
      "Mod+Shift+Ctrl+K" = a "move-column-to-monitor-up";
      "Mod+Shift+Ctrl+L" = a "move-column-to-monitor-right";

      "Mod+Page_Down" = a "focus-workspace-down";
      "Mod+Page_Up" = a "focus-workspace-up";
      "Mod+U" = a "focus-workspace-down";
      "Mod+I" = a "focus-workspace-up";
      "Mod+Ctrl+Page_Down" = a "move-column-to-workspace-down";
      "Mod+Ctrl+Page_Up" = a "move-column-to-workspace-up";
      "Mod+Ctrl+U" = a "move-column-to-workspace-down";
      "Mod+Ctrl+I" = a "move-column-to-workspace-up";
      "Mod+Shift+Page_Down" = a "move-workspace-down";
      "Mod+Shift+Page_Up" = a "move-workspace-up";
      "Mod+Shift+U" = a "move-workspace-down";
      "Mod+Shift+I" = a "move-workspace-up";

      "Mod+1" = aw "focus-workspace" 1;
      "Mod+2" = aw "focus-workspace" 2;
      "Mod+3" = aw "focus-workspace" 3;
      "Mod+4" = aw "focus-workspace" 4;
      "Mod+5" = aw "focus-workspace" 5;
      "Mod+6" = aw "focus-workspace" 6;
      "Mod+7" = aw "focus-workspace" 7;
      "Mod+8" = aw "focus-workspace" 8;
      "Mod+9" = aw "focus-workspace" 9;
      "Mod+Ctrl+1" = aw "move-column-to-workspace" 1;
      "Mod+Ctrl+2" = aw "move-column-to-workspace" 2;
      "Mod+Ctrl+3" = aw "move-column-to-workspace" 3;
      "Mod+Ctrl+4" = aw "move-column-to-workspace" 4;
      "Mod+Ctrl+5" = aw "move-column-to-workspace" 5;
      "Mod+Ctrl+6" = aw "move-column-to-workspace" 6;
      "Mod+Ctrl+7" = aw "move-column-to-workspace" 7;
      "Mod+Ctrl+8" = aw "move-column-to-workspace" 8;
      "Mod+Ctrl+9" = aw "move-column-to-workspace" 9;

      "Mod+WheelScrollDown" = (a "focus-workspace-down") // { cooldown-ms = 150; };
      "Mod+WheelScrollUp" = (a "focus-workspace-up") // { cooldown-ms = 150; };
      "Mod+Ctrl+WheelScrollDown" = (a "move-column-to-workspace-down") // { cooldown-ms = 150; };
      "Mod+Ctrl+WheelScrollUp" = (a "move-column-to-workspace-up") // { cooldown-ms = 150; };
      "Mod+WheelScrollRight" = a "focus-column-right";
      "Mod+WheelScrollLeft" = a "focus-column-left";
      "Mod+Ctrl+WheelScrollRight" = a "move-column-right";
      "Mod+Ctrl+WheelScrollLeft" = a "move-column-left";
      "Mod+Shift+WheelScrollDown" = a "focus-column-right";
      "Mod+Shift+WheelScrollUp" = a "focus-column-left";
      "Mod+Ctrl+Shift+WheelScrollDown" = a "move-column-right";
      "Mod+Ctrl+Shift+WheelScrollUp" = a "move-column-left";

      "Mod+BracketLeft" = a "consume-or-expel-window-left";
      "Mod+BracketRight" = a "consume-or-expel-window-right";
      "Mod+R" = a "switch-preset-column-width";
      "Mod+Shift+R" = a "switch-preset-window-height";
      "Mod+Ctrl+R" = a "reset-window-height";
      "Mod+F" = a "maximize-column";
      "Mod+Shift+F" = a "fullscreen-window";
      "Mod+Ctrl+F" = a "expand-column-to-available-width";
      "Mod+C" = a "center-column";
      "Mod+Ctrl+C" = a "center-visible-columns";
      "Mod+Minus" = aw "set-column-width" "-10%";
      "Mod+Equal" = aw "set-column-width" "+10%";
      "Mod+Shift+Minus" = aw "set-window-height" "-10%";
      "Mod+Shift+Equal" = aw "set-window-height" "+10%";
      "Mod+W" = a "toggle-column-tabbed-display";

      #"Mod+Ctrl+Y" = a "screenshot";
      #"Mod+Shift+Y" = a "screenshot-screen";
      #"Mod+Alt+Y" = a "screenshot-window";

      "Mod+Ctrl+Y" = { action."spawn-sh" = ''grim -g "$(slurp -o -r -c '#ff0000ff')" -t png - | satty --filename - --fullscreen --copy-command=wl-copy --actions-on-escape="save-to-clipboard,exit" --output-filename "$HOME/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H%M%S').png"''; };
      "Mod+Shift+Y" = { action."spawn-sh" = ''grim -g "$(slurp -d -c '#ff0000ff')" -t png - | satty --filename - --fullscreen --copy-command=wl-copy --actions-on-escape="save-to-clipboard,exit" --output-filename "$HOME/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H%M%S').png"''; };

      "XF86AudioRaiseVolume" = { action."spawn-sh" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; allow-when-locked = true; };
      "XF86AudioLowerVolume" = { action."spawn-sh" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; allow-when-locked = true; };
      "XF86AudioMute" = { action."spawn-sh" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; allow-when-locked = true; };
      "XF86AudioMicMute" = { action."spawn-sh" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; allow-when-locked = true; };

      "XF86AudioPlay" = { action."spawn-sh" = "playerctl play-pause"; allow-when-locked = true; };
      "XF86AudioStop" = { action."spawn-sh" = "playerctl stop"; allow-when-locked = true; };
      "XF86AudioPrev" = { action."spawn-sh" = "playerctl previous"; allow-when-locked = true; };
      "XF86AudioNext" = { action."spawn-sh" = "playerctl next"; allow-when-locked = true; };

      "XF86MonBrightnessUp" = { action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"]; allow-when-locked = true; };
      "XF86MonBrightnessDown" = { action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"]; allow-when-locked = true; };

      "Mod+Escape" = (a "toggle-keyboard-shortcuts-inhibit") // { allow-inhibiting = false; };
      "Mod+Shift+E" = a "quit";
      "Ctrl+Alt+Delete" = a "quit";
      "Mod+Shift+O" = { action.spawn = ["swaylock"]; hotkey-overlay.title = "Lock Screen"; };
    };
  };
}
