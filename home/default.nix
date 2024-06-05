{ pkgs, username, unstable, spicetify-nix, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./bash
    ./betterlockscreen
    ./btop
    ./dunst
    ./firefox
    ./neofetch
    ./nvim
    ./picom
    ./qtile
    ./thunar
    ./tmux
    ./zsh

    ./cursor.nix
    ./extra_files.nix
    ./flameshot.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "22.11";
    sessionVariables = {
      EDITOR = pkgs.nano;
    };

    packages =
      let
        figma-linux-wrap = with pkgs; figma-linux.overrideAttrs (prev: {
          nativeBuildInputs = prev.nativeBuildInputs ++ [ wrapGAppsHook ];
        });

        discord-patched = unstable.discord.override {
          withVencord = true;
        };

      in
      with pkgs; [
        # settings
        arandr
        brightnessctl
        lxappearance

        figma-linux-wrap

        # volume
        pamixer
        pulsemixer
        pavucontrol

        # messaging
        teams-for-linux
        discord-patched
        thunderbird
        telegram-desktop
        matrix-commander

        # dev
        clang-tools
        llvmPackages_latest.clang
        gnumake
        tokei
        wakatime
        (pkgs.callPackage ./logisim.nix { })
        jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        jetbrains.clion
        quartus-prime-lite
        kicad
        jupyter

        # misc
        spotify
        spicetify-cli
        gimp
        neofetch
        pass
        prismlauncher
        steam

        # utils
        peek
        ripgrep
        dconf
        xclip
        lshw
      ];
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      config.theme = "base16";
    };

    dircolors.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    feh.enable = true;
    lazygit = {
      enable = true;
      settings.git.commit = {
        signOff = true;
      };
      settings.gui = {
        nerdFontsVersion = "3";
      };
      settings.overrideGpg = true;
    };
  };
}
