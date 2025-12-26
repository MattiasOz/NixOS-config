# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

# let 
#   # grubCyberpunk = pkgs.fetchFromGitHub {
#   #   owner = "adnksharp";
#   #   repo = "CyberGRUB-2077";
#   #   rev = "6b736816e8034157b7a643e1088d1303c267d0d0";
#   #   hash = "sha256-Od2+YczAPZr4nIbQA1FTucEhq4zEceuuhhFTEbCn4sk=";
#   # };
#   grubSmth = pkgs.fetchFromGitHub { # current as of 11/2022
#     owner = "vinceliuice";
#     repo = "Elegant-grub2-themes";
#     rev = "8f36b5dde2361c902656bc82890f2902baa3c6c4";
#     sha256 = "sha256-M9k6R/rUvEpBTSnZ2PMv5piV50rGTBrcmPU4gsS7Byg=";
#   };
# in
let 
  grubCyberpunk = pkgs.stdenv.mkDerivation {
    pname = "CyberGrub";
    version = "1.3";
    src = pkgs.fetchFromGitHub {
      owner = "adnksharp";
      repo = "CyberGRUB-2077";
      rev = "6b736816e8034157b7a643e1088d1303c267d0d0";
      hash = "sha256-Od2+YczAPZr4nIbQA1FTucEhq4zEceuuhhFTEbCn4sk=";
    };
    installPhase = ''
      mkdir -p $out/share/grub/themes/CyberGRUB
      cp -r CyberGRUB-2077/* $out
    '';
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nord.nix
    ];
  myypo.services.custom.nordvpn.enable=true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 10;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
    default = "saved";
    # theme = grubCyberpunk;
    # theme = grubSmth;
    theme = grubCyberpunk;
  };

  # boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
  #   pname = "CyberGrub";
  #   version = "1.0";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "adnksharp";
  #     repo = "CyberGRUB-2077";
  #     rev = "6b736816e8034157b7a643e1088d1303c267d0d0";
  #     hash = "sha256-Od2+YczAPZr4nIbQA1FTucEhq4zEceuuhhFTEbCn4sk=";
  #   };
  #   # installPhase = "cp -r customize/nixos $out";
  #   installPhase = ''
  #     mkdir -p $out/share/grub/themes/CyberGRUB
  #     cp -r CyberGRUB/* $out/share/grub/themes/CyberGRUB/
  #   '';
  # };

  networking.hostName = "Phaenon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = false;
  #services.libinput.enable = false;
  services.xserver.synaptics.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mattias = {
    isNormalUser = true;
    description = "Mattias";
    extraGroups = [ "networkmanager" "wheel" "docker" "nordvpn"];
    # packages = with pkgs; [
    #   kdePackages.kate
    # #  thunderbird
    # ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # swap and hibernation
  boot.initrd.systemd.enable = true;
  # security.protectKernelImage = false;
  # boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/aad204fb-4f3e-4fa7-b70b-1921b2be9963";
  # # boot.resumeDevice = "/dev/disk/by-uuid/b43e67e7-bd14-41a9-a574-b8b70866f5d0";
  # boot.resumeDevice = "/dev/mapper/cryptroot";
  # boot.kernelParams = [
  #   # "resume=/dev/mapper/luks-aad204fb-4f3e-4fa7-b70b-1921b2be9963"
  #   # "resume_offset=41086976"
  #   # "resume_offset=389120"
  #   # "resume=/dev/disk/by-uuid/aad204fb-4f3e-4fa7-b70b-1921b2be9963"
  #   "resume=/dev/mapper/cryptroot"
  #   "resume_offset=41015296"
  # ];
  # boot.resumeDevice = [
  #   { device="/var/swapfile"};
  # ];
  # boot.resumeDevice = "/var/swapfile";
  # boot.resumeDevice = "/dev/mapper/luks-aad204fb-4f3e-4fa7-b70b-1921b2be9963";
  # powerManagement.enable = true;
  swapDevices = [
    {
      device = "/var/swapfile";
      size = 16 * 1024;
    }
  ];
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=3h
    SuspendState=mem
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    home-manager
    nix-search-cli
    neofetch
    htop
    zsh
    zsh-powerlevel10k
    yazi
    kdePackages.yakuake
    kdePackages.filelight
    brave
    git
    gcc
    zellij
    docker
    vlc
    p7zip
    tree

    gparted
    exfatprogs # enables gparted to use format to exfat
    #gnome-icon-theme # should enable gparted to display the icon but is doesn't work
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack # used for icons
  ];

  programs.zsh.enable = true;
  users.users.mattias.shell = pkgs.zsh;
  virtualisation.docker.enable = true;

  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if ((action.id == "org.freedesktop.login1.hinernate") &&
  #         subject.isInGroup("users")) {
  #       return polkit.Result.YES;
  #       }
  #   });
  # '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = lib.mkForce []; # should disable autostart

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
