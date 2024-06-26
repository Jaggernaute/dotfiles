from functools import partialmethod

from libqtile import widget
from libqtile.lazy import lazy

from utils import Color


def mk_overrides(cls, **conf):
    init_method = partialmethod(cls.__init__, **conf)
    return type(cls.__name__, (cls,), {"__init__": init_method})

CPUGraph = mk_overrides(
    widget.CPUGraph, type="line", line_width=1, border_width=0,
    graph_color=Color.PINK_UWU
)

GroupBox = mk_overrides(
    widget.GroupBox,
    highlight_method="line",
    disable_drag=True,
    other_screen_border=Color.PINK_UWU,
    other_current_screen_border=Color.PINK_UWU,
    this_screen_border=Color.PINK_UWU,
    this_current_screen_border=Color.PINK_UWU,
    block_highlight_text_color=Color.TEXT_LIGHT,
    highlight_color=[Color.PINK_UWU, Color.PINK_UWU],
    inactive=Color.TEXT_INACTIVE,
    active=Color.TEXT_LIGHT,
)

Memory = mk_overrides(
    widget.Memory,
    format="{MemUsed: .3f}Mb",
    mouse_callbacks={
        "Button1": lazy.spawn(
            "kitty"
            " -o initial_window_width=1720"
            " -o initial_window_height=860"
            " -e btop"
        )
    },
)

TaskList = mk_overrides(
    widget.TaskList,
    icon_size=0,
    fontsize=12,
    borderwidth=2,
    margin=0,
    padding=4,
    txt_floating="",
    highlight_method="text",
    title_width_method="uniform",
    spacing=8,
    foreground=Color.TEXT_LIGHT,
    background=Color.BG_DARK.with_alpha(0.8),
    border=Color.PINK_UWU,
)

Separator = mk_overrides(widget.Spacer, length=4)
Clock = mk_overrides(widget.Clock, format="%A, %b %-d %H:%M")


QuickExit = mk_overrides(
    widget.QuickExit, default_text="⏻", countdown_format="{}"
)

Prompt = mk_overrides(
    widget.Prompt,
    prompt=">",
    bell_style="visual",
    background=Color.BG_DARK,
    foreground=Color.TEXT_LIGHT,
    padding=8,
)

Systray = mk_overrides(
    widget.Systray,
    icon_size=14,
    padding=8
)
