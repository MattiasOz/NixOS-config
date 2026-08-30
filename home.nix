{ config, pkgs, ... }:
let
  # rustPlatform = pkgs.makeRustPlatform {
  #   # cargo = pkgs.rustc;
  #   # rustc = pkgs.rustc;
  #   cargo = pkgs.rust-bin.stable.latest.minimal;
  #   rustc = pkgs.rust-bin.stable.latest.minimal;
  # };  
  sattyMats = pkgs.rustPlatform.buildRustPackage {
    pname = "sattyMats";
    version = "0.20.1";

    src = /home/mattias/Documents/satty/Satty-0.20.1;


    nativeBuildInputs = with pkgs; [
      copyDesktopItems
      pkg-config
      wrapGAppsHook4
      installShellFiles
    ];

    buildInputs = with pkgs; [
      gdk-pixbuf
      glib
      gtk4
      libadwaita
      libepoxy
      libGL
    ];

    postInstall = ''
      install -Dt $out/share/icons/hicolor/scalable/apps/ assets/satty.svg

      installShellCompletion --cmd satty \
        --bash completions/satty.bash \
        --fish completions/satty.fish \
        --zsh completions/_satty
    '';

    desktopItems = [ "satty.desktop" ];
    cargoHash = "sha256-/WewpLpBmD4XnjwY7NmzbglYGNKmgMLjg1pvUdqEIwo=";
  };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mattias";
  home.homeDirectory = "/home/mattias";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     satty = prev.satty.overrideAttrs (old : {
  #       src = /home/mattias/Documents/satty/Satty-0.20.1;
  #       cargoHash = "";
  #     });
  #   })
  # ];
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
    # oh-my-zsh
    # zsh-powerlevel10k
    # starship
    #neovim
    eza
    wl-clipboard
    ryubing
    yt-dlp
    discord
    nix-prefetch-github
    transmission_4-qt
    ncdu
    android-tools # for adb
    conda
    android-studio
    obs-studio
    ani-cli
    tigervnc
    #libreoffice # for .docx
    gimp
    # rustup
    cargo
    rustc
    expect # using unbuffer in the yay replacement function
    # cockatrice # mtg client
    (pkgs.cockatrice.overrideAttrs (oldAttrs: rec {
      version = "3.0.0";
      date = "2026-05-08";
      src = pkgs.fetchFromGitHub {
        owner = "Cockatrice";
        repo = "Cockatrice";
        rev = "${date}-Release-${version}";
        sha256 = "sha256-jLHGWtHbJTQ5Gefrnd8aUq1K3f2QzyE4YU5bW//gH4Y=";
        # sha256 = "sha256-lxhjJPna76Xb/LEMMfzUXe3ZIh1xYpS4yZSZuWkaVq4=";
      };
    }))
    browsh
    # quickshell # hyprland bar
    # wayle   #hyprland bar
    # wofi # hyprland menu search
    rofi
    # hyprland-workspaces
    brightnessctl
    grim  #grim and satty are for screenshotting and editing
    # sattyMats
    satty
    networkmanagerapplet
    blueman
    nixfmt
    # wallrizz #for changing wallpaper and themes
    bat # for styling like with lsblk | bat -l conf -p

    # read markdown in terminal. Command: pandoc -f markdown <file/content> | lynx -stdin
    #pandoc
    #lynx

    # for vimtex
    # texlivePackages.bibtex
    # texliveFull   # moved to the plugin menu directly
    # texlivePackages.biblatex

    #citrix_workspace_25_08_10 # for accessing LTU cloud PCs
    #citrix_workspace_25_03_0
    # virtualbox
  ];
  nixpkgs.config.allowUnfree = true; # for discord
  nixpkgs.config.android_sdk.accept_license = true;

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
  #  /etc/profiles/per-user/mattias/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    # ./thesis.nix
    ./zsh/zsh.nix
    ./yazi.nix
    ./yakuake.nix
    #./nvim.nix
    ./nixvim/nixvim.nix
    ./ideavim.nix
    ./zellij.nix
    # ./hyprland/hyprland.nix
  ];

  #programs.neovim = {
  #  enable = true;
  #  #defaultEditor = true;
  #  plugins = with pkgs.vimPlugins; [
  #    #nvchad
  #    #nvchad-ui
  #    nvim-lspconfig
  #    mason-nvim
  #  ];
  #};

  # adds z
  programs.z-lua.enable = true;
  programs.zsh.initContent = ''
    eval "$(z --init zsh enhanced)"
  '';
  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.systemd.enable = true;
  # wayland.windowManager.hyprland.systemd.variables = [
  #   "--all"
  # ];
    # enable = true;
    # exec-once = [
    #   "quickshell"
    # ];
  # };
  programs.kitty = {
    enable = true;
    settings = {
      dynamic_background_opacity = true;
      background_opacity = 0.6;

      #Konsole Breeze Dark
      background="#232627";
      selection_background="#3daee9";
      foreground="#fcfcfc";
      selection_foreground="#fcfcfc";
      cursor="#fcfcfc";
      cursor_text_color="#232627";
      url_color="#3daee9";
      color0="#232627";
      color1="#ed1515";
      color2="#11d116";
      color3="#f67400";
      color4="#1d99f3";
      color5="#9b59b6";
      color6="#1abc9c";
      color7="#fcfcfc";
      color8="#7f8c8d";
      color9="#c0392b";
      color10="#1cdc9a";
      color11="#fdbc4b";
      color12="#3daee9";
      color13="#8e44ad";
      color14="#16a085";
      color15="#ffffff";
      active_tab_background="#3daee9";
      active_tab_foreground="#fcfcfc";
      inactive_tab_background="#31363b";
      inactive_tab_foreground="#eff0f1";
    };
    # themeFile="Konsole_Breeze_Dark";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
