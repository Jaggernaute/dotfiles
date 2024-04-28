{ username, config, hostname, pkgs, ... }:
{
  imports =
    [
      ./polkit.nix
    ];

  boot = {
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      kernelModules = [ "amdgpu" ];
    };

    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080x32";
      };
    };
  };

  nix = {
    gc = {
      automatic = true;
hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;      options = "--delete-older-than 90d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      keep-outputs = true;
      keep-derivations = true;
      auto-optimise-store = true;
    };
    optimise.automatic = true;
  };

  environment.pathsToLink = [ "/share/nix-direnv" ];
  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    earlySetup = true;
    useXkbConfig = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    colors = [
      "11111E" # Black
      "E12541" # red
      "14C67B" # green
      "FFAC7D" # yellow
      "7270FF" # blue
      "FD8DFF" # magenta
      "75DFED" # cyan
      "A4B1E3" # white

      "474B77" # light black
      "DE6876" # light red
      "63D961" # light green
      "FFDA8D" # light yellow
      "AAA9FA" # light blue
      "E5A5FB" # light magenta
      "BEEDF8" # light cyan
      "DBE2FB" # light white
    ];
  };

  hardware = {

    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport32Bit = true;

      #---------------------------------------------------------------------
      # Install additional packages that improve graphics performance and compatibility.
      #---------------------------------------------------------------------
      extraPackages = with pkgs; [

        amdvlk
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        vulkan-validation-layers
      ];
    };

    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  programs = {
    command-not-found.enable = false;
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    zsh.enable = true;
    noisetorch.enable = true;
  };

  security.rtkit.enable = true;
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    openssh.enable = true;
    blueman.enable = true;

    picom = {
      enable = true;
      fade = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      # config = (builtins.readFile ./xorg.conf);
      dpi = 90;
      videoDrivers = [ "nvidia" ];
      enable = true;
      displayManager.startx.enable = true;
      layout = "us";
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
      };
      windowManager.qtile = {
        enable = true;
        backend = "x11";
      };
    };

    upower.enable = true;

    udev.packages = [ pkgs.usb-blaster-udev-rules ];
  };

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "audio" "docker" "networkmanager" "libvirtd" "wheel" ];
    initialPassword = "hello";
  };

  fonts.packages = with pkgs; let
    jetbrains-mono-nerd-font = (nerdfonts.override
      { fonts = [ "JetBrainsMono" ]; });
  in
  [
    jetbrains-mono-nerd-font
    dina-font
    fira-code
    fira-code-symbols
    liberation_ttf
    mplus-outline-fonts.githubRelease
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    proggyfonts
    apl386
  ];

  documentation.dev.enable = true;
  environment = {
    etc.issue.text = (builtins.readFile ./issuerc);
    sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };

    shells = [ pkgs.zsh ];
    systemPackages = with pkgs; [
      alsa-utils
      modemmanager
      networkmanagerapplet
      libsForQt5.ark
      libsForQt5.plasma-nm
      playerctl
      libudev0-shim

      git
      htop
      tree
      vim
      vifm
      wget

      floorp

      libnotify
      virt-manager

      man-pages
      man-pages-posix

      zip
      unzip
    ];
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "22.11";
  };

  qt.style = "adwaita-dark";
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-kde
    ];
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.cups-toshiba-estudio ];
  };
}
