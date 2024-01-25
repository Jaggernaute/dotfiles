{ ... }:
{
  home.file = {
    xinitrc = {
      source = ./../.xinitrc;
      target = ".xinitrc";
    };

    wallpaper = {
      source = ./../assets;
      target = "assets";
      recursive = true;
    };
  };
}
