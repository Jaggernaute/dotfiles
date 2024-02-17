{ pkgs, username, nix-doom-emacs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    nix-doom-emacs.hmModule

    ./bash
    ./betterlockscreen
    ./btop
    ./dunst
    ./emacs
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

        discord-patched = pkgs.discord.override {withVencord = true;};

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

        # dev
        gnumake
        tokei
        wakatime
        (pkgs.callPackage ./logisim.nix {})
        jetbrains.idea-ultimate
        quartus-prime-lite
        emacsPackages.doom

        # misc
        spotify
        gimp
        neofetch
        pass
        prismlauncher

        # utils
        peek
        ripgrep
        dconf
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
    lazygit.enable = true;
  };
}
