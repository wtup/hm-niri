{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      alias mount_rpi="rclone --ignore-size --ignore-checksum --vfs-cache-mode full mount --daemon CSL-PD:RPI ~/projects/RPI/sharepoint"
      alias mount_skif="rclone --ignore-size --ignore-checksum --vfs-cache-mode full mount --daemon CSL-PD:SKIF ~/projects/SKIF/sharepoint"
      alias mount_slri="rclone --ignore-size --ignore-checksum --vfs-cache-mode full mount --daemon CSL-PD:SLRI ~/projects/SLRI/sharepoint"
      alias mount_tarla="rclone --ignore-size --ignore-checksum --vfs-cache-mode full mount --daemon CSL-PD:TARLA ~/projects/$1/sharepoint"
      alias mount_sp="rclone --ignore-size --ignore-checksum --vfs-cache-mode full mount --daemon CSL-PD:$1 ~/projects/$1/sharepoint"
      alias record_audio="ffmpeg -f pulse -i default -f pulse -i default.monitor -filter_complex amix=inputs=2 $argv"
      fish_add_path "$HOME/.local/bin"
      fish_add_path "$HOME/.local/share/nvm/v24.4.0/bin/"

      source "$HOME/.cargo/env.fish"
      set fish_greeting
      direnv hook fish | source
      set GIT_EDITOR nvim

      fish_add_path "~/.nix-profile/bin"
      if test -d "$HOME/.nix-profile/share"
          set -x XDG_DATA_DIRS "$HOME/.nix-profile/share" $XDG_DATA_DIRS
      end
    '';
    functions = {
      y = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
      # task add project:$1 $2
      tap = ''
        task add project:$argv[1] $argv[2]
      '';
      # task add project:$1 $2
      tt = ''
        task +today
      '';
      # task add project:$1 $2
      tn = ''
        task +next
      '';
    };
  };
}
