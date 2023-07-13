# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./starship.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.additions
      inputs.emacs-overlay.overlays.default

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [ "electron-21.4.0" ];
    };
  };

  home = {
    username = "hudson";
    homeDirectory = "/home/hudson";
  };

  home.packages = with pkgs; [
    gnomeExtensions.timepp
    notion-app-enhanced
    bottom
    steam
    nixfmt
    htop
    discord
    asdf-vm

    # cc
    # clang
    gcc
    bear
    gdb
    cmake
    llvmPackages.libcxx

    # python
    python3Full

    # clojure
    clojure
    joker
    leiningen

    # rust
    llvm
    # rust-analyzer
    # cargo
    rustup
    # rustc
    sccache
    protobuf
    binutils
    libGL
    libiconv

    # jdk
    jdk11

    # docker
    docker
    docker-compose

    # javascript
    nodejs
    nodePackages.yalc
    # nodePackages.typescript-language-server
    nodePackages.javascript-typescript-langserver
    nodePackages.jsonlint
    nodePackages.yarn
    nodePackages_latest.typescript

    # libre office
    libreoffice

    # spotify
    spotify

    evince
    xournalpp
    _1password-gui
    lua
    imagemagick
    sqlite
    glibc

    # elixir
    elixir
    erlang
    rebar3

    # postgres
    # postgresql_15

    # other packages
    wget
    firefox
    unzip
    unrar
    glxinfo
    nvtop-nvidia
    nvidia-offload
    vlc
    zsh
    nix-zsh-completions
    fasd
    fd
    fzf
    tldr
    ripgrep
    lolcat
    screenfetch
    tdesktop
    alacritty
    kitty
    neofetch
    gimp
    inkscape
    blender
    scour
    peek
    bat
    bc
    bind
    cached-nix-shell
    cachix
    coreutils
    direnv
    obs-studio
    curl
    dmidecode
    exa
    git
    gitAndTools.gh
    speedtest-cli
    jq
    ngrok
    file
    i7z
    iw
    jq
    netcat
    nix-index
    nix-tree
    openssl
    pkg-config
    patchelf
    tree
    vim
    wget
    zlib
    todoist-electron
    gtk3
    deluge
    starship
    tmux
    zoom-us
    aspellDicts.pt_BR
    aspellDicts.en
    aspell
    sd
    silver-searcher
    xsel
    xclip

    # emacs dependencies
    gnutls
    zstd
    editorconfig-core-c
    beancount

    # gnome extensions
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.space-bar
    gnomeExtensions.vitals
    gnomeExtensions.user-themes
    gnomeExtensions.pop-shell
    # gnomeExtensions.appindicator
    gnomeExtensions.mpris-label
    gnomeExtensions.no-activities-button
    gnomeExtensions.caffeine
    pop-gtk-theme
    gnomeExtensions.resource-monitor

    # gnome pop-shell launcher
    pop-icon-theme
    pop-launcher

    # Fonts
    hack-font
    roboto
    roboto-mono
    material-design-icons
    ibm-plex
    nerdfonts
    dejavu_fonts
    liberation_ttf
    roboto
    fira-code
    fira-code-symbols
    jetbrains-mono
    siji
    font-awesome
    cascadia-code
    (nerdfonts.override { fonts = [ "Meslo" ]; })
    speedtest-cli
  ];

  # enable font manager
  fonts.fontconfig.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs = {
    firefox.enableGnomeExtensions = true;
    git = {
      enable = true;
      package = pkgs.gitAndTools.hub;
      userName = "Hudson Couto";
      userEmail = "hudson.sama@gmail.com";
      includes = [{ path = "~/codes/nix-config/config/gitconfig"; }];
    };
    bottom.enable = true;
    autojump.enable = true;
    bat.enable = true;
    exa.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
      fileWidgetOptions = [ "--preview 'bat --color always {}'" ];
    };
    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [ packer-nvim vim-nix ];
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];
      # dotDir = ".config/zsh";
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "aliases"
          "sudo"
          "direnv"
          "emoji"
          "encode64"
          "jsontools"
          "systemd"
          "dirhistory"
          "colored-man-pages"
          "command-not-found"
          "extract"
          "ruby"
          "docker"
          "rust"
          "rails"
          "fzf"
          "tmuxinator"
          "postgres"
        ];
        # customPkgs = with pkgs; [ nix-zsh-completions ];
      };
      initExtra = ''
        export XDG_DATA_HOME="$HOME/.local/share"

        source ~/.custom_aliases
      '';
    };

    tmux = {
      enable = true;
      clock24 = true;
      shell = "${pkgs.zsh}/bin/zsh";
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-powerline true
            set -g @dracula-refresh-rate 5
            set -g @dracula-show-left-icon 
            set -g @dracula-plugins "time"
            set -g @dracula-show-timezone false

            # set -g @dracula-network-bandwidth wlan0
            # set -g @dracula-network-bandwidth-interval 0
            # set -g @dracula-network-bandwidth-show-interface true
          '';
        }
      ];

      extraConfig = ''
        set -g @plugin 'tmux-plugins/tmux-yank'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g @plugin 'dracula/tmux'

        set -g default-terminal "screen-256color"

        # Dracula Color Pallette
        white='#f8f8f2'
        gray='#44475a'
        dark_gray='#282a36'
        light_purple='#bd93f9'
        dark_purple='#6272a4'
        cyan='#8be9fd'
        green='#50fa7b'
        orange='#ffb86c'
        red='#ff5555'
        pink='#ff79c6'
        yellow='#f1fa8c'

        # window title
        set -g set-titles on
        setw -g set-titles-string '#{b:pane_current_path}'

        # Binds
        # unbind C-b
        # set -g prefix M-e
        # bind -n M-a send-prefix
        bind-key -n M-x kill-pane
        bind-key -n M-n new-window
        bind-key -n M-c new-window -c '#{pane_current_path}'
        bind -n M-Right next-window
        bind -n M-Left previous-window
        bind-key -n M-h split-window -h -c '#{pane_current_path}'
        bind-key -n M-v split-window -v -c '#{pane_current_path}'
        bind-key -n M-o select-pane -t :.+
        bind-key M-a last-window
        bind-key -n M-f resize-pane -Z
        # bind-key -n F10 resize-pane -Z
        bind-key m set-option -g mouse on \; display 'Mouse: ON'
        bind-key M set-option -g mouse off \; display 'Mouse: OFF'
        bind-key -n S-Left select-pane -L
        bind-key -n S-Right select-pane -R
        bind-key -n S-Up select-pane -U
        bind-key -n S-Down select-pane -D
        bind-key -n C-S-Left resize-pane -L
        bind-key -n C-S-Right resize-pane -R
        bind-key -n C-S-Up resize-pane -U
        bind-key -n C-S-Down resize-pane -D
        bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection c"
        bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard  > /dev/null"

        # create session
        bind C-c new-session

        # find session
        bind C-f command-prompt -p find-session 'switch-client -t %%'
        # last window
        # bind C-Tab last-window
        set -s escape-time 0
        # set-option -g allow-rename off
        set-option -g mouse on
        set -g history-limit 10000
        setw -g mode-keys vi

        set-option -g automatic-rename on
        set-option -g automatic-rename-format '#{b:pane_current_path}'
        setw -g automatic-rename on   # rename window to reflect current program
        set -g renumber-windows on    # renumber windows when a window is closed
        set -g monitor-activity on
        set -g visual-activity off

        # set-window-option -g window-status-current-format "#[fg=$gray,bg=$dark_purple]$left_sep#[fg=$white,bg=$dark_purple] #W$current_flags #[fg=$dark_purple,bg=$gray]$left_sep"
        # set-window-option -g window-status-format "#[fg=$white]#[bg=$gray] #W$flags"
      '';
    };

    # emacs
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = (epkgs: [ epkgs.vterm ]);
    };
  };

  services.emacs = {
    enable = true;
    # package = pkgs.emacs-unstable-pgtk;
    package = pkgs.emacs-pgtk;
    client.enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
    extraOptions = [ ];
  };

  # dconf config
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "emacs.desktop"
          "Alacritty.desktop"
          "spotify.desktop"
          "org.gnome.Nautilus.desktop"
          "1password.desktop"
          "todoist-electron.desktop"
        ];
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          # "appindicatorsupport@rgcjonas.gmail.com"
          "pop-shell@system76.com"
          "no_activities@yaya.cout"
          "caffeine@patapon.info"
          "trayIconsReloaded@selfmade.pl"
          # "Vitals@CoreCoding.com"
          "Resource_Monitor@Ory0n"
          "space-bar@luchrioh"
        ];
      };
      # "org/gnome/shell/extensions/user-theme" = {
      #   name = "palenight";
      # };
      "org/gnome/desktop/interface" = {
        # monospace-font-name = "MesloLGS Nerd Font Mono Regular 10";
        color-scheme = "prefer-dark";
        enable-animations = false;
      };
      # "org/gnome/shell/extensions/vitals" = {
      #   show-storage = true;
      #   show-voltage = true;
      #   show-memory = true;
      #   show-fan = true;
      #   show-temperature = true;
      #   show-processor = true;
      #   show-network = true;
      #   icon-margin-horizontal = 2;
      #   icon-padding-horizontal = 5;
      #   icon-size = 20;
      #   icons-limit = 5;
      #   position-weight = 2;
      #   tray-margin-left = 4;
      # };
      "org/gnome/mutter" = {
        edge-tiling = true;
        workspaces-only-on-primary = false;
        dynamic-workspaces = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        workspace-names = [ "󰞷" "󰗀" "󰊯" "󰷏" "󰋩" ];
        num-workspaces = 5;
        # focus-mode = "sloppy";
        focus-mode = "click";
      };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = "uint32 3500";
        night-light-schedule-automatic = true;
      };
      "org/gnome/eog/ui" = { image-gallery = true; };
      # Enable and configure pop-shell
      # (see https://github.com/pop-os/shell/blob/master_jammy/scripts/configure.sh)
      "org/gnome/shell/extensions/pop-shell" = {
        # active-hint = true;
        mouse-cursor-focus-location = "uint32 1";
        mouse-cursor-follows-active-window = true;
        show-skip-taskbar = true;
        show-title = false;
      };
      "org/gnome/desktop/wm/keybindings" = {
        minimize = [ "<Super>comma" ];
        maximize = [ ];
        unmaximize = [ ];
        switch-to-workspace-left = [ ];
        switch-to-workspace-right = [ ];
        move-to-monitor-up = [ ];
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ ];
        move-to-monitor-right = [ ];
        move-to-workspace-down = [ ];
        move-to-workspace-up = [ ];
        switch-to-workspace-down =
          [ "<Primary><Super>Down" "<Primary><Super>j" ];
        switch-to-workspace-up = [ "<Primary><Super>Up" "<Primary><Super>k" ];
        toggle-maximized = [ "<Super>m" ];
        close = [ "<Super>q" "<Alt>F4" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
      };
      "org/gnome/shell/keybindings" = {
        open-application-menu = [ ];
        toggle-message-tray = [ "<Super>v" ];
        toggle-overview = [ ];
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ ];
        toggle-tiled-right = [ ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        screensaver = "@as ['<Super>Escape']";
        rotate-video-lock-static = [ ];
        home = [ "<Super>f" ];
        email = [ ];
        www = [ "<Super>b" ];
        terminal = [ ];
      };
      "org/gnome/mutter/wayland/keybindings" = { restore-shortcuts = [ ]; };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          binding = "<Super>t";
          command = "alacritty"; # TODO: use configured "default"
          name = "Open Alacritty";
        };
    };
  };

  # gtk config
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 16;
    };
    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
      size = 10;
    };
  };

  # qt config
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.libsForQt5.qtstyleplugins;
    };
  };

  # zsh scripts
  home.file.".custom_aliases".source = ./custom_aliases;

  # variables
  home.sessionPath =
    [ "$HOME/.cargo/bin" "$HOME/.emacs.d/bin" "$HOME/.local/bin" ];

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    DOOMDIR = "${config.xdg.configHome}/doom";
    DOOMLOCALDIR = "${config.xdg.configHome}/emacs";
    QT_QPA_PLATFORM = "wayland";
    # GTK_THEME = "palenight";
  };
  # xdg = {
  #   enable = true;
  #   configFile = {
  #     "doom" = {
  #       source = ../config/doom;
  #       recursive = true;
  #       onChange = ''
  #         export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
  #         export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
  #         if [ ! -d "$DOOMLOCALDIR" ]; then
  #           git clone git@github.com:doomemacs/doomemacs.git ~/.config/emacs
  #           ${config.xdg.configHome}/emacs/bin/doom -y install
  #         else
  #           ${config.xdg.configHome}/emacs/bin/doom -y sync -u
  #         fi
  #       '';
  #     };
  #     "emacs" = {
  #       source = builtins.fetchGit {
  #         url = "https://github.com/doomemacs/doomemacs";
  #         ref = "master";
  #         rev = "042fe0c43831c8575abfdec4196ebd7305fa16ac";
  #       };
  #       onChange = "${pkgs.writeShellScript "doom-change" ''
  #         export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
  #         export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
  #         if [ ! -d "$DOOMLOCALDIR" ]; then
  #           ${config.xdg.configHome}/emacs/bin/doom -y install
  #         else
  #           ${config.xdg.configHome}/emacs/bin/doom -y sync -u
  #         fi
  #       ''}";
  #     };
  #   };
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # create symbolic links
  home.activation.linkMyFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/alacritty/
    mkdir -p ~/.config/alacritty/themes/

    ln -Tsf ~/codes/nix-config/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
    ln -Tsf ~/codes/nix-config/config/alacritty/dracula.yml ~/.config/alacritty/themes/dracula.yml

    ln -Tsf ~/codes/nix-config/config/doom ~/.config/doom
  '';

  # setup cursor pointer
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
