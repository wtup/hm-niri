{config, ... }:
{
  programs.dank-material-shell = {
    enable = true;

    settings = {
      enableVPN = true;
      enableDynamicTheming = true;
      customPowerActionLock = "swaylock";
      mutagenTemplateNeovim = false;
    };
    niri = {
      #enableKeybinds = true;
      enableSpawn = true;
    };
  };
  programs.niri = {
    settings.binds = {
      "Mod+V" = { action.spawn = ["dms" "ipc" "clipboard" "toggle"]; hotkey-overlay.title = "Toggle Clipboard Manager";};
      "Mod+Shift+P" = { action.spawn = ["dms" "ipc" "powermenu" "toggle"]; hotkey-overlay.title = "Toggle Power Menu";};
      "Mod+Alt+N" = { action.spawn = ["dms" "ipc" "night" "toggle"]; hotkey-overlay.title = "Toggle Night Mode";};
      "Mod+Comma" = { action.spawn = ["dms" "ipc" "settings" "toggle"]; hotkey-overlay.title = "Toggle Settings";};
      "Mod+P" = { action.spawn = ["dms" "ipc" "notepad" "toggle"]; hotkey-overlay.title = "Toggle Notepad";};
      "Mod+M" = { action.spawn = ["dms" "ipc" "processlist" "toggle"]; hotkey-overlay.title = "Toggle Process List";};
      "Mod+N" = { action.spawn = ["dms" "ipc" "notifications" "toggle"]; hotkey-overlay.title = "Toggle Notification Center";};
      "Mod+D" = { action.spawn = ["dms" "ipc" "spotlight" "toggle"]; hotkey-overlay.title = "Toggle Application Launcher";};
    };
  };

}

