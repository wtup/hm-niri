{config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lperusko";
  home.homeDirectory = "/home/lperusko";
  home.pointerCursor = {
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
    gtk.enable = true;
  };
  #
  # This is needed for non nixos hosts to use gpu libs
  targets.genericLinux.gpu.enable = true;
  #xdg.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    waybar
    fuzzel
    mako
    zellij
    lazygit
    neovim
    nodejs_24
    pdfgrep
    uv
    vale-ls
    yazi
    yt-dlp
    wl-clipboard
    brightnessctl
    playerctl
    keepassxc
    #openssh
    #swaylock
    #TODO: check if this is installed on the system

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  #programs.gpg.package = pkgs.gnupg.override { pcsclite = pkgs.pcsclite_old; };

  # NOTE: uncomment if tou wanna use hyprlock
  # pamShim.enable = true;
  #
  # programs.hyprlock = {
  #   package = config.lib.pamShim.replacePam pkgs.hyprlock;
  #   settings.auth."fingerprint:enabled" = true;
  #};


  # programs.dank-material-shell.quickshell.package = config.lib.pamShim.replacePam dms.packages.x86_64-linux.quickshell;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # stylix = {
  #   enable = true;
  #   # Predogled in imena barv: https://dt.iki.fi/base16-previews
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  #   image = ./walls/spiderverse.png;
  #   polarity = "dark";
  #
  #   icons = {
  #     enable = true;
  #     light = "breeze";
  #     dark = "breeze-dark";
  #   };
  #
  #   fonts = {
  #     serif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Serif";
  #     };
  #
  #     sansSerif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Sans";
  #     };
  #
  #     monospace = {
  #       package = pkgs.nerd-fonts.hack;
  #       name = "FiraCode Nerd Font";
  #     };
  #
  #     emoji = {
  #       package = pkgs.noto-fonts-color-emoji;
  #       name = "Noto Color Emoji";
  #     };
  #   };
  #
  #   targets.qt.enable = true;
  #   targets.kde.enable = true;
  #   targets.kde.useWallpaper = false;
  #   targets.fzf.enable = false;
  #   targets.emacs.enable = false;
  # };
  #   ● The files listed in the error output:
  #
  #   - ~/.Xresources — X11 resource settings
  #   - ~/.gtkrc-2.0 — GTK2 theme config
  #   - ~/.config/gtk-4.0/gtk.css — GTK4 custom CSS
  #   - ~/.config/gtk-4.0/settings.ini — GTK4 settings
  #   - ~/.config/gtk-3.0/gtk.css — GTK3 custom CSS
  #   - ~/.config/gtk-3.0/settings.ini — GTK3 settings
  #   - ~/.config/forge/stylesheet/forge/stylesheet.css — GNOME Forge extension stylesheet
  #
  #   These are all theming-related files that Stylix now wants to manage. Your
  #   existing copies will be renamed to <filename>.backup.


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lperusko/etc/profile.d/hm-session-vars.sh
  #

  #programs.ssh = {
  #  enable = true;
  #  enableDefaultConfig = false;
  #  package = pkgs.openssh;
  #};

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CURRENT_DESKTOP = "GNOME";
    SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/gcr/ssh";
  };

  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Adwaita";
  #     package = pkgs.adwaita-icon-theme;
  #   };
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

