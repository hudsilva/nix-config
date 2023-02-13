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
      inputs.emacs-overlay.overlay

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
    };
  };

  home = {
    username = "hudson";
    homeDirectory = "/home/hudson";
  };

  home.packages = with pkgs; [
    steam
    nixfmt
    bottom
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
    python-language-server

    # clojure
    clojure
    joker
    leiningen

    # rust
    llvm
    rust-analyzer
    cargo
    # rustup
    rustc
    rustfmt
    sccache
    protobuf
    binutils
    libGL

    # jdk
    jdk11

    # docker
    docker
    docker-compose

    # javascript
    nodejs
    nodePackages.yalc
    nodePackages.typescript-language-server
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
    transmission-gtk
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

  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs = {
    git.enable = true;
    bottom.enable = true;
    autojump.enable = true;
    bat.enable = true;
    direnv.enable = true;
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
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      # dotDir = ".config/zsh";
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "aliases"
          "sudo"
          "direnv"
          "emacs"
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
      # plugins = with pkgs.tmuxPlugins; [
      #   sensible
      #   yank
      #   {
      #     plugin = dracula;
      #     extraConfig = ''
      #       set -g @dracula-show-battery false
      #       set -g @dracula-show-powerline true
      #       set -g @dracula-refresh-rate 10
      #       set -g @dracula-show-fahrenheit false
      #       set -g @dracula-show-weather false
      #       set -g @dracula-show-left-icon 
      #       '';
      #   }
      # ];

      extraConfig = ''
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g @plugin 'dracula/tmux'

        set -g default-terminal "screen-256color"
        set -g @dracula-plugins "network time"
        set -g @dracula-show-timezone false
        set -g @dracula-show-powerline true
        set -g @dracula-show-left-icon 

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

        run -b '~/.tmux/plugins/tpm/tpm
      '';
    };

    # emacs
    emacs = {
      enable = true;
      package = pkgs.emacsGit;
      extraPackages = (epkgs: [ epkgs.vterm ]);
    };
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacsGit;
    client.enable = true;
  };

  # zsh scripts
  home.file.".custom_aliases".source = ./custom_aliases;

  # variables
  home.sessionPath =
    [ "$HOME/.cargo/bin" "$HOME/.emacs.d/bin" "$HOME/.local/bin" ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
