import pathlib
import os
import random

from libqtile.bar import Gap
from libqtile.config import Screen

from core.bar import Bar

gap = Gap(4)
_cwd = pathlib.Path(os.path.dirname(os.path.realpath(__file__)))
wallpaper_path = os.path.expanduser(f"~/assets/wall-{random.randint(23,23):02d}.png")

if not os.path.exists(wallpaper_path):
    wallpaper_path = str((_cwd / ".." / ".." / "wall-23.png").absolute())

_gap = Gap(4)
_screen_attr = dict(
    bottom=_gap, left=_gap, right=_gap,
    wallpaper=wallpaper_path,
    wallpaper_mode="fill")

screens = [Screen(top=Bar(i), **_screen_attr) for i in range(2)]
