{ ... }:
{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "-u ~/assets/lockscreen.png" ];
  };

  home.file.betterlockscreenrc = {
    source = ./betterlockscreenrc;
    target = ".config/betterlockscreenrc";
  };
}
