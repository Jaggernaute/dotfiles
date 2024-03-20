import pathlib
import os
import random

from libqtile.bar import Gap
from libqtile.config import Screen

from core.bar import Bar

gap = Gap(4)

_cwd = pathlib.Path(os.path.dirname(os.path.realpath(__file__)))

wallpaper_path = os.path.expanduser(f"~/assets/wall-{random.randint(21,22):02d}.png")

if not os.path.exists(wallpaper_path):
    wallpaper_path = str((_cwd / ".." / ".." / "wall-22.png").absolute())

screens = [
    Screen(
        top=Bar(i),
        bottom=gap,
        left=gap,
        right=gap,
        wallpaper=wallpaper_path,
        wallpaper_mode="fill",
    )
    for i in range(2)
]
