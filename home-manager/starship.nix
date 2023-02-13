{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      # format = "$all";
      # format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
      line_break = {
        disabled = true;
      };
      aws = {
        style = "bold #ffb86c";
        # format = "[$symbol($profile )(($region) )([$duration] )]($style)";
        # symbol = "🅰 ";
        # style = "bold yellow";
        # disabled = false;
        # expiration_symbol = "X";
        # force_display = false;
      };
      c = {
        format = "[$symbol($version(-$name) )]($style)";
        version_format = "v$raw";
        style = "fg:149 bold bg:0x86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = [
          "c"
            "h"
        ];
        detect_files = [];
        detect_folders = [];
        # commands = [
        #   [
        #     "cc"
        #       "--version"
        #   ]
        #   [
        #   "gcc"
        #     "--version"
        #   ]
        #   [
        #   "clang"
        #     "--version"
        #   ]
        # ];
      };
      cmd_duration = {
        min_time = 2000;
        format = "⏱ [$duration]($style) ";
        style = "bold #f1fa8c";
        show_milliseconds = false;
        disabled = false;
        show_notifications = false;
        min_time_to_notify = 45000;
      };
      character = {
        success_symbol = "[λ](bold #f8f8f2)";
        error_symbol = "[λ](bold #ff5555)";
      };
      container = {
        format = "[$symbol [$name]]($style) ";
        symbol = "⬢";
        style = "red bold dimmed";
        disabled = false;
      };
      dart = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🎯 ";
        style = "bold blue";
        disabled = false;
        detect_extensions = ["dart"];
        detect_files = [
          "pubspec.yaml"
            "pubspec.yml"
            "pubspec.lock"
        ];
        detect_folders = [".dart_tool"];
      };
      directory = {
        style = "bold #50fa7b";
        truncate_to_repo = false;
      };
      directory.substitutions = {
        # Here is how you can shorten some long paths by text replacement;
        # similar to mapped_locations in Oh My Posh:;
        "Documents" = " ";
        "Downloads" = " ";
        "Music" = " ";
        "Pictures" = " ";
        "codes" = " codes";
        # Keep in mind that the order matters. For example:;
        # "Important Documents" = "  ";
        # will not be replaced, because "Documents" was already substituted before.;
        # So either put "Important Documents" before "Documents" or use the substituted version:;
        # "Important  " = "  ";
        "Important " = " ";
      };
      docker_context = {
        format = "[$symbol$context]($style) ";
        style = "blue bold bg:0x06969A";
        symbol = "  ";
        only_with_files = true;
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "docker-compose.yml"
            "docker-compose.yaml"
            "Dockerfile"
        ];
        detect_folders = [];
      };
      elixir = {
        format = "[$symbol($version (OTP $otp_version) )]($style)";
        version_format = "v$raw";
        style = "bold purple bg:0x86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = [];
        detect_files = ["mix.exs"];
        detect_folders = [];
      };
      erlang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = " ";
        style = "bold red";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "rebar.config"
            "erlang.mk"
        ];
        detect_folders = [];
      };
      gcloud = {
        format = "[$symbol(@$domain-$project)]($style) ";
        symbol = "☁️ ";
        style = "bold blue";
        disabled = false;
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        symbol = " ";
        style = "bold #ff79c6";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        only_attached = false;
        always_show_remote = false;
        ignore_branches = [];
        disabled = false;
      };
      git_commit = {
        commit_hash_length = 7;
        format = "[($hash$tag)]($style) ";
        style = "green bold";
        only_detached = true;
        disabled = false;
        tag_symbol = " 🏷  ";
        tag_disabled = true;
      };
      git_metrics = {
        added_style = "bold green";
        deleted_style = "bold red";
        only_nonzero_diffs = true;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        disabled = false;
      };
      git_status = {
        style = "bold #ff5555";
        # format = '([\[$all_status$ahead_behind\]]($style) )';
      };
      golang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = " ";
        style = "bold cyan bg:0x86BBD8";
        disabled = false;
        detect_extensions = ["go"];
        detect_files = [
          "go.mod"
            "go.sum"
            "glide.yaml"
            "Gopkg.yml"
            "Gopkg.lock"
            ".go-version"
        ];
        detect_folders = ["Godeps"];
      };
      haskell = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "λ ";
        style = "bold purple bg:0x86BBD8";
        disabled = false;
        detect_extensions = [
          "hs"
            "cabal"
            "hs-boot"
        ];
        detect_files = [
          "stack.yaml"
            "cabal.project"
        ];
        detect_folders = [];
      };
      helm = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "⎈ ";
        style = "bold white";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "helmfile.yaml"
            "Chart.yaml"
        ];
        detect_folders = [];
      };
      hostname = {
        disabled = true;
        format = "[$ssh_symbol](blue dimmed bold)[$hostname]($style) ";
        ssh_only = false;
        style = "bold #bd93f9";
        trim_at = ".";
      };
      java = {
        disabled = false;
        format = "[$symbol($version )]($style)";
        style = "red dimmed bg:0x86BBD8";
        symbol = " ";
        version_format = "v$raw";
        detect_extensions = [
          "java"
            "class"
            "jar"
            "gradle"
            "clj"
            "cljc"
        ];
        detect_files = [
          "pom.xml"
            "build.gradle.kts"
            "build.sbt"
            ".java-version"
            "deps.edn"
            "project.clj"
            "build.boot"
        ];
        detect_folders = [];
      };
      jobs = {
        threshold = 1;
        symbol_threshold = 0;
        number_threshold = 2;
        format = "[$symbol$number]($style) ";
        symbol = "✦";
        style = "bold blue";
        disabled = true;
      };
      kubernetes = {
        disabled = false;
        format = "[$symbol$context( ($namespace))]($style) in ";
        style = "cyan bold";
        symbol = "⛵ ";
      };
      kubernetes.context_aliases = {};
      lua = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🌙 ";
        style = "bold blue";
        lua_binary = "lua";
        disabled = false;
        detect_extensions = ["lua"];
        detect_files = [".lua-version"];
        detect_folders = ["lua"];
      };
      nim = {
        format = "[$symbol($version )]($style)";
        style = "yellow bold bg:0x86BBD8";
        symbol = " ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = [
          "nim"
            "nims"
            "nimble"
        ];
        detect_files = ["nim.cfg"];
        detect_folders = [];
      };
      nix_shell = {
        format = "[$symbol$state( ($name))]($style) ";
        disabled = false;
        impure_msg = "[impure](bold red)";
        pure_msg = "[pure](bold green)";
        style = "bold blue";
        symbol = "  ";
      };
      nodejs = {
        format = "[$symbol($version )]($style)";
        not_capable_style = "bold red";
        style = "bold green bg:0x86BBD8";
        symbol = " ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = [
          "js"
            "mjs"
            "cjs"
            "ts"
            "mts"
            "cts"
        ];
        detect_files = [
          "package.json"
            ".node-version"
            ".nvmrc"
        ];
        detect_folders = ["node_modules"];
      };
      package = {
        format = "[$symbol$version]($style) ";
        symbol = "📦 ";
        style = "208 bold";
        display_private = false;
        disabled = false;
        version_format = "v$raw";
      };
      python = {
        format = "[$symbol$pyenv_prefix($version )(($virtualenv) )]($style)";
        python_binary = [
          "python"
            "python3"
            "python2"
        ];
        pyenv_prefix = "pyenv ";
        pyenv_version_name = true;
        style = "yellow bold";
        symbol = "  ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = ["py"];
        detect_files = [
          "requirements.txt"
            ".python-version"
            "pyproject.toml"
            "Pipfile"
            "tox.ini"
            "setup.py"
            "__init__.py"
        ];
        detect_folders = [];
      };
      ruby = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        # symbol = "💎 ";
        symbol = " ";
        style = "bold red";
        disabled = false;
        detect_extensions = ["rb"];
        detect_files = [
          "Gemfile"
            ".ruby-version"
        ];
        detect_folders = [];
        detect_variables = [
          "RUBY_VERSION"
            "RBENV_VERSION"
        ];
      };
      rust = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🦀 ";
        style = "bold red bg:0x86BBD8";
        disabled = false;
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
        detect_folders = [];
      };
      scala = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        disabled = false;
        style = "red bold";
        symbol = "🆂 ";
        detect_extensions = [
          "sbt"
            "scala"
        ];
        detect_files = [
          ".scalaenv"
            ".sbtenv"
            "build.sbt"
        ];
        detect_folders = [".metals"];
      };
      shell = {
        format = "[$indicator]($style) ";
        bash_indicator = "bsh";
        cmd_indicator = "cmd";
        elvish_indicator = "esh";
        fish_indicator = "";
        ion_indicator = "ion";
        nu_indicator = "nu";
        powershell_indicator = "_";
        style = "white bold";
        tcsh_indicator = "tsh";
        unknown_indicator = "mystery shell";
        xonsh_indicator = "xsh";
        zsh_indicator = "❄️ ";
        disabled = true;
      };
      status = {
        format = "[$symbol$status]($style) ";
        map_symbol = true;
        not_executable_symbol = "🚫";
        not_found_symbol = "🔍";
        pipestatus = false;
        pipestatus_format = "[$pipestatus] => [$symbol$common_meaning$signal_name$maybe_int]($style)";
        pipestatus_separator = "|";
        recognize_signal_code = true;
        signal_symbol = "⚡";
        style = "bold red bg:blue";
        success_symbol = "🟢 SUCCESS";
        symbol = "🔴 ";
        disabled = true;
      };
      sudo = {
        format = "[as $symbol]($style)";
        symbol = "🧙 ";
        style = "bold blue";
        allow_windows = false;
        disabled = true;
      };
      time = {
        format = "[$symbol $time]($style) ";
        style = "bold yellow bg:0x33658A";
        use_12hr = false;
        disabled = true;
        utc_time_offset = "local";
        # time_format = "%R"; # Hour:Minute Format;
        time_format = "%T"; # Hour:Minute:Seconds Format;
        time_range = "-";
      };
      username = {
        disabled = false;
        format = "[$user]($style) ";
        style_user = "bold #8be9fd";
        style_root = "red bold bg:0x9A348E";
      };
    };
  };
}
