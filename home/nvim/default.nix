{ pkgs, system, ... }:

let
  nvchad = pkgs.stdenv.mkDerivation {
    pname = "nvchad";
    version = "1.0.0";
    dontBuild = true;

    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "NvChad";
      rev = "c8777040fbda6a656f149877b796d120085cd918";
      sha256 = "sha256-J4SGwo/XkKFXvq+Va1EEBm8YOQwIPPGWH3JqCGpFnxY=";
    };

    installPhase = ''
      runHook preInstall

      mkdir $out

      cp -aR $src/* $out/

      chmod +w $out/lua
      cp -r ${./custom} $out/lua/custom

      runHook postInstall
    '';
  };
in
{
  programs.neovim.enable = true;

  xdg.configFile."nvim/" = {
    source = nvchad;
  };
}
