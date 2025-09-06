{ pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true; # or Bash/Fish

    # Configuration skeleton copied from https://gist.github.com/s-a-c/0e44dc7766922308924812d4c019b109#file-starship-nix/
    settings = {
      # Insert a blank line between shell prompts
      add_newline = true;

      # palettes.catppuccin_macchiato = {
      #   rosewater = "#f4dbd6";
      #   flamingo = "#f0c6c6";
      #   pink = "#f5bde6";
      #   mauve = "#c6a0f6";
      #   red = "#ed8796";
      #   maroon = "#ee99a0";
      #   peach = "#f5a97f";
      #   yellow = "#eed49f";
      #   green = "#a6da95";
      #   teal = "#8bd5ca";
      #   sky = "#91d7e3";
      #   sapphire = "#7dc4e4";
      #   blue = "#8aadf4";
      #   lavender = "#b7bdf8";
      #   text = "#cad3f5";
      #   subtext1 = "#b8c0e0";
      #   subtext0 = "#a5adcb";
      #   overlay2 = "#939ab7";
      #   overlay1 = "#8087a2";
      #   overlay0 = "#6e738d";
      #   surface2 = "#5b6078";
      #   surface1 = "#494d64";
      #   surface0 = "#363a4f";
      #   base = "#24273a";
      #   mantle = "#1e2030";
      #   crust = "#181926";
      # };
      palette = "mats";
      palettes.mats = {
        vit = "#FFFFFF";
        "grå" = "#777777";
        # "blå" = "#3b76f0";
        "blå" = "#1c98f3";
        orange = "#f77401";
        text_light = "#e5e4e5";
        text_dark = "#2a2827";
      };

      # Increase the default command timeout to 2 seconds
      command_timeout = 2000;
      continuation_prompt = "[∙](bright-black) ";
      right_format = "";

      # Define the order and format of the information in our prompt
      # format = ''
      # [](fg:#3B76F0)
      # $directory
      # $symbol($git_branch[](fg:#FCF392))
      # $symbol( $git_commit$git_status$git_metrics$git_state)$fill$cmd_duration$nodejs$all
      # $character
      # '';
      #symbols     
      format = "[](vit)[ ](fg:text_dark bg:vit)[](fg:vit bg:blå)$localip$directory$custom$git_branch$git_commit$git_state$git_metrics$git_status$\{custom.directory_separator_git_after\}$docker_context$nix_shell$conda$env_var$sudo$fill$cmd_duration[](fg:grå)$memory_usage[](fg:grå)$line_break$jobs$battery$status$character";
      #$hg_branch$package$buf[](fg:#FCA17D bg:#86BBD8)$c$cmake$cobol$container$daml$dart$deno$dotnet$elixir$elm$erlang$golang$haskell$helm$java$julia$kotlin$lua$nim$nodejs$ocaml$perl$php$pulumi$purescript$python$rlang$red$ruby$rust$scala$swift$terraform$vlang$vagrant$zig$spack$aws$gcloud$openstack$azure$crystal$time$shlvl$singularity$kubernetes$vcsh[](fg:blå bg:#DA627D)$username$hostname$shell
      # format = "[](blå)$username$hostname$localip$shlvl$singularity$kubernetes[](fg:blå bg:#DA627D)$directory$vcsh[](fg:#DA627D bg:#FCA17D)$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch[](fg:#86BBD8 bg:#06969A)$docker_context$package$buf[](fg:#FCA17D bg:#86BBD8)$c$cmake$cobol$container$daml$dart$deno$dotnet$elixir$elm$erlang$golang$haskell$helm$java$julia$kotlin$lua$nim$nodejs$ocaml$perl$php$pulumi$purescript$python$rlang$red$ruby$rust$scala$swift$terraform$vlang$vagrant$zig$nix_shell$conda$spack$memory_usage$aws$gcloud$openstack$azure$env_var$crystal$custom$sudo$cmd_duration$line_break$jobs$battery[](fg:#06969A bg:#33658A)$time$status$shell$character";
      scan_timeout = 30;

      # Customize the format of the working directory

      aws = {
        format = "[$symbol($profile )(($region) )([$duration] )]($style)";
        symbol = "🅰 ";
        style = "bold yellow";
        disabled = false;
        expiration_symbol = "X";
        force_display = false;
      };
      aws.region_aliases = {};
      aws.profile_aliases = {};
      azure = {
        format = "[$symbol($subscription)([$duration])]($style) ";
        symbol = "ﴃ ";
        style = "blue bold";
        disabled = true;
      };
      battery = {
        format = "[$symbol$percentage]($style) ";
        # charging_symbol = " ";
        # discharging_symbol = " ";
        # empty_symbol = " ";
        # full_symbol = " ";
        # unknown_symbol = " ";
        disabled = false;
        display = [
          {
            style = "red bold";
            threshold = 20;
          }
        ];
      };
      buf = {
        format = "[$symbol ($version)]($style)";
        version_format = "v$raw";
        symbol = "";
        style = "bold blue";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "buf.yaml"
          "buf.gen.yaml"
          "buf.work.yaml"
        ];
        detect_folders = [];
      };
      c = {
        format = "[$symbol($version(-$name) )]($style)";
        version_format = "v$raw";
        style = "fg:149 bold bg:#86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = [
          "c"
          "h"
        ];
        detect_files = [];
        detect_folders = [];
        commands = [
          [
            "cc"
            "--version"
          ]
          [
            "gcc"
            "--version"
          ]
          [
            "clang"
            "--version"
          ]
        ];
      };
      character = {
        format = "$symbol ";
        vicmd_symbol = "[❮](bold green)";
        disabled = false;
        success_symbol = "[❯](bold green) ";  #➜
        error_symbol = "[✗](bold red) ";
      };
      cmake = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "△ ";
        style = "bold blue";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "CMakeLists.txt"
          "CMakeCache.txt"
        ];
        detect_folders = [];
      };
      cmd_duration = {
        min_time = 2000;
        format = " [$duration]($style) "; #⏱
        style = "yellow bold";
        show_milliseconds = false;
        disabled = false;
        show_notifications = false;
        min_time_to_notify = 45000;
      };
      cobol = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "⚙️ ";
        style = "bold blue";
        disabled = false;
        detect_extensions = [
          "cbl"
          "cob"
          "CBL"
          "COB"
        ];
        detect_files = [];
        detect_folders = [];
      };
      conda = {
        truncation_length = 1;
        format = "[$symbol$environment]($style) ";
        symbol = " ";
        style = "green bold";
        ignore_base = true;
        disabled = false;
      };
      container = {
        format = "[$symbol [$name]]($style) ";
        symbol = "⬢";
        style = "red bold dimmed";
        disabled = false;
      };
      crystal = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🔮 ";
        style = "bold red";
        disabled = false;
        detect_extensions = ["cr"];
        detect_files = ["shard.yml"];
        detect_folders = [];
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
      deno = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🦕 ";
        style = "green bold";
        disabled = false;
        detect_extensions = [];
        detect_files = [
          "deno.json"
          "deno.jsonc"
          "mod.ts"
          "deps.ts"
          "mod.js"
          "deps.js"
        ];
        detect_folders = [];
      };
      directory = {
        disabled = false;
        fish_style_pwd_dir_length = 0;
        format = "[   $path ]($style)[$read_only]($read_only_style)";
        # symbol = " ";  #🗀🗁
        home_symbol = "~";
        # read_only = " ";
        read_only_style = "red bg:blå";
        repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        style = "text_light bold bg:blå";
        truncate_to_repo = false;
        truncation_length = 0;  #to remove truncation
        # truncation_symbol = "…/";
        use_logical_path = true;
        use_os_path_sep = true;
      };
      # directory.substitutions = {
      #   # Here is how you can shorten some long paths by text replacement;
      #   # similar to mapped_locations in Oh My Posh:;
      #   "~" = " ";
      #   # "Home" = " ";
      #   # "Documents" = " ";
      #   # "Downloads" = " ";
      #   # "Music" = " ";
      #   # "Pictures" = " ";
      #   # Keep in mind that the order matters. For example:;
      #   # "Important Documents" = "  ";
      #   # will not be replaced, because "Documents" was already substituted before.;
      #   # So either put "Important Documents" before "Documents" or use the substituted version:;
      #   # "Important  " = "  ";
      #   # "Important " = " ";
      # };
      docker_context = {
        format = "[$symbol$context]($style) ";
        style = "blue bold bg:#06969A";
        symbol = " ";
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
      dotnet = {
        format = "[$symbol($version )(🎯 $tfm )]($style)";
        version_format = "v$raw";
        symbol = "🥅 ";
        style = "blue bold";
        heuristic = true;
        disabled = false;
        detect_extensions = [
          "csproj"
          "fsproj"
          "xproj"
        ];
        detect_files = [
          "global.json"
          "project.json"
          "Directory.Build.props"
          "Directory.Build.targets"
          "Packages.props"
        ];
        detect_folders = [];
      };
      elixir = {
        format = "[$symbol($version (OTP $otp_version) )]($style)";
        version_format = "v$raw";
        style = "bold purple bg:#86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = [];
        detect_files = ["mix.exs"];
        detect_folders = [];
      };
      elm = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        style = "cyan bold bg:#86BBD8";
        symbol = " ";
        disabled = false;
        detect_extensions = ["elm"];
        detect_files = [
          "elm.json"
          "elm-package.json"
          ".elm-version"
        ];
        detect_folders = ["elm-stuff"];
      };
      env_var = {};
      env_var.SHELL = {
        format = "[$symbol($env_value )]($style)";
        style = "grey bold italic dimmed";
        symbol = "e:";
        disabled = true;
        variable = "SHELL";
        default = "unknown shell";
      };
      env_var.USER = {
        format = "[$symbol($env_value )]($style)";
        style = "grey bold italic dimmed";
        symbol = "e:";
        disabled = true;
        default = "unknown user";
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
      fill = {
        style = "bold black";
        symbol = "·";
        disabled = false;
      };
      gcloud = {
        format = "[$symbol$account(@$domain)(($region))(($project))]($style) ";
        symbol = "☁️ ";
        style = "bold blue";
        disabled = false;
      };
      gcloud.project_aliases = {};
      gcloud.region_aliases = {};
      git_branch = {
        format = "[$symbol$branch(:$remote_branch) ]($style)";
        symbol = " ";
        style = "bold text_dark bg:orange";
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
        style = "text_dark bold bg:orange";
        only_detached = true;
        disabled = false;
        tag_symbol = " 🏷  ";
        tag_disabled = true;
      };
      git_metrics = {
        added_style = "bold text_dark bg:orange";
        deleted_style = "bold text_dark bg:orange";
        only_nonzero_diffs = true;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        disabled = true;
      };
      git_state = {
        am = "AM";
        am_or_rebase = "AM/REBASE";
        bisect = "BISECTING";
        cherry_pick = "🍒PICKING(bold red)";
        disabled = false;
        format = "([$state( $progress_current/$progress_total) ]($style))";
        merge = "MERGING";
        rebase = "REBASING";
        revert = "REVERTING";
        style = "bold text_dark bg:orange";
      };
      git_status = {
        ahead = "⇡$count ";
        behind = "⇣$count ";
        conflicted = "=$count ";
        deleted = "✘$count ";
        disabled = false;
        diverged = "⇕";
        format = "([$all_status$ahead_behind]($style))";
        ignore_submodules = false;
        modified = "!$count ";
        renamed = "»$count ";
        staged = "++$count ";
        stashed = "\$$count ";
        style = "text_dark bold bg:orange";
        untracked = "?$count ";
        up_to_date = "✓";
      };
      golang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = " ";
        style = "bold cyan bg:#86BBD8";
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
        style = "bold purple bg:#86BBD8";
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
      hg_branch = {
        symbol = " ";
        style = "bold purple";
        format = "on [$symbol$branch]($style) ";
        truncation_length = 9223372036854775807;
        truncation_symbol = "…";
        disabled = true;
      };
      hostname = {
        disabled = false;
        format = "[$ssh_symbol](blue dimmed bold)[$hostname]($style)";
        ssh_only = false;
        style = "green dimmed bold bg:blå";
        trim_at = ".";
      };
      java = {
        disabled = false;
        format = "[$symbol($version )]($style)";
        style = "red dimmed bg:#86BBD8";
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
        disabled = false;
      };
      julia = {
        disabled = false;
        format = "[$symbol($version )]($style)";
        style = "bold purple bg:#86BBD8";
        symbol = " ";
        version_format = "v$raw";
        detect_extensions = ["jl"];
        detect_files = [
          "Project.toml"
          "Manifest.toml"
        ];
        detect_folders = [];
      };
      kotlin = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🅺 ";
        style = "bold blue";
        kotlin_binary = "kotlin";
        disabled = false;
        detect_extensions = [
          "kt"
          "kts"
        ];
        detect_files = [];
        detect_folders = [];
      };
      kubernetes = {
        disabled = false;
        format = "[$symbol$context( ($namespace))]($style) in ";
        style = "cyan bold";
        symbol = "⛵ ";
      };
      kubernetes.context_aliases = {};
      line_break = {
        disabled = false;
      };
      localip = {
        disabled = true;
        format = "[@$localipv4]($style)";
        ssh_only = false;
        style = "yellow bold bg:blå";
      };
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
      memory_usage = {
        disabled = false;
        format = "[$ram( | $swap)]($style)";
        style = "white bold dimmed bg:grå";
        # symbol = "";
        # threshold = 75;
        threshold = -1;
      };
      nim = {
        format = "[$symbol($version )]($style)";
        style = "yellow bold bg:#86BBD8";
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
        symbol = " ";
      };
      nodejs = {
        format = "[$symbol($version )]($style)";
        not_capable_style = "bold red";
        style = "bold green bg:#86BBD8";
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
      ocaml = {
        format = "[$symbol($version )(($switch_indicator$switch_name) )]($style)";
        global_switch_indicator = "";
        local_switch_indicator = "*";
        style = "bold yellow";
        symbol = "🐫 ";
        version_format = "v$raw";
        disabled = false;
        detect_extensions = [
          "opam"
          "ml"
          "mli"
          "re"
          "rei"
        ];
        detect_files = [
          "dune"
          "dune-project"
          "jbuild"
          "jbuild-ignore"
          ".merlin"
        ];
        detect_folders = [
          "_opam"
          "esy.lock"
        ];
      };
      openstack = {
        format = "[$symbol$cloud(($project))]($style) ";
        symbol = "☁️  ";
        style = "bold yellow";
        disabled = false;
      };
      package = {
        format = "[$symbol$version]($style) ";
        symbol = "📦 ";
        style = "208 bold";
        display_private = false;
        disabled = false;
        version_format = "v$raw";
      };
      perl = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🐪 ";
        style = "149 bold";
        disabled = false;
        detect_extensions = [
          "pl"
          "pm"
          "pod"
        ];
        detect_files = [
          "Makefile.PL"
          "Build.PL"
          "cpanfile"
          "cpanfile.snapshot"
          "META.json"
          "META.yml"
          ".perl-version"
        ];
        detect_folders = [];
      };
      php = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🐘 ";
        style = "147 bold";
        disabled = false;
        detect_extensions = ["php"];
        detect_files = [
          "composer.json"
          ".php-version"
        ];
        detect_folders = [];
      };
      pulumi = {
        format = "[$symbol($username@)$stack]($style) ";
        version_format = "v$raw";
        symbol = " ";
        style = "bold 5";
        disabled = false;
      };
      purescript = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "<=> ";
        style = "bold white";
        disabled = false;
        detect_extensions = ["purs"];
        detect_files = ["spago.dhall"];
        detect_folders = [];
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
        symbol = "🐍 ";
        version_format = "v$raw";
        disabled = true;
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
      red = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🔺 ";
        style = "red bold";
        disabled = false;
        detect_extensions = [
          "red"
          "reds"
        ];
        detect_files = [];
        detect_folders = [];
      };
      rlang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        style = "blue bold";
        symbol = "📐 ";
        disabled = false;
        detect_extensions = [
          "R"
          "Rd"
          "Rmd"
          "Rproj"
          "Rsx"
        ];
        detect_files = [".Rprofile"];
        detect_folders = [".Rproj.user"];
      };
      ruby = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "💎 ";
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
        style = "bold red bg:#86BBD8";
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
        zsh_indicator = "zsh";
        disabled = false;
      };
      shlvl = {
        threshold = 2;
        format = "[$symbol$shlvl]($style) ";
        symbol = "↕️  ";
        repeat = false;
        style = "bold yellow";
        disabled = true;
      };
      singularity = {
        format = "[$symbol[$env]]($style) ";
        style = "blue bold dimmed";
        symbol = "📦 ";
        disabled = false;
      };
      spack = {
        truncation_length = 1;
        format = "[$symbol$environment]($style) ";
        symbol = "🅢 ";
        style = "blue bold";
        disabled = false;
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
      swift = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "🐦 ";
        style = "bold 202";
        disabled = false;
        detect_extensions = ["swift"];
        detect_files = ["Package.swift"];
        detect_folders = [];
      };
      terraform = {
        format = "[$symbol$workspace]($style) ";
        version_format = "v$raw";
        symbol = "💠 ";
        style = "bold 105";
        disabled = false;
        detect_extensions = [
          "tf"
          "tfplan"
          "tfstate"
        ];
        detect_files = [];
        detect_folders = [".terraform"];
      };
      time = {
        format = "[$symbol $time]($style) ";
        style = "bold yellow bg:#33658A";
        use_12hr = false;
        disabled = false;
        utc_time_offset = "local";
        # time_format = "%R"; # Hour:Minute Format;
        time_format = "%T"; # Hour:Minute:Seconds Format;
        time_range = "-";
      };
      username = {
        format = "[$user]($style)";
        show_always = true;
        style_root = "red bold bg:#9A348E";
        # style_user = "yellow bold bg:blå";
        style_user = "text_light bold bg:blå";
        disabled = false;
      };
      vagrant = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "⍱ ";
        style = "cyan bold";
        disabled = false;
        detect_extensions = [];
        detect_files = ["Vagrantfile"];
        detect_folders = [];
      };
      vcsh = {
        symbol = "";
        style = "bold yellow";
        format = "[$symbol$repo]($style) ";
        disabled = true;
      };
      vlang = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "V ";
        style = "blue bold";
        disabled = false;
        detect_extensions = ["v"];
        detect_files = [
          "v.mod"
          "vpkg.json"
          ".vpkg-lock.json"
        ];
        detect_folders = [];
      };
      zig = {
        format = "[$symbol($version )]($style)";
        version_format = "v$raw";
        symbol = "↯ ";
        style = "bold yellow";
        disabled = false;
        detect_extensions = ["zig"];
        detect_files = [];
        detect_folders = [];
      };
      custom = {
      };

      # Output the current git config email address
      # custom.git_config_email = {
      #   description = "Output the current git user's configured email address.";
      #   command = "git config user.email";
      #   format = "\n[$symbol(  $output)]($style)";
      #   # Only when inside git repository
      #   when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1";
      #   style = "text";
      # };

      # Output a styled separator right after the directory when inside a git repository.
      custom.directory_separator_git_before = {
        description = "Output a styled separator right after the directory when inside a git repository.";
        command = "";
        format = "[ ](fg:blå bg:orange)";
        when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1";
      };

      # Output a styled separator right after the directory when NOT inside a git repository.
      custom.directory_separator_not_git = {
        description = "Output a styled separator right after the directory when NOT inside a git repository.";
        command = "";
        format = "[](fg:blå)";
        when = "! git rev-parse --is-inside-work-tree > /dev/null 2>&1";
      };

      custom.directory_separator_git_after = {
        description = "Output a styled separator right after the directory when inside a git repository.";
        command = "";
        format = "[](fg:orange)";
        when = "git rev-parse --is-inside-work-tree >/dev/null 2>&1";
      };
    };
  };
}
