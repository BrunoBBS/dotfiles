from libqtile.config import Key, Screen, Group, Drag, Click, hook
from libqtile.command import lazy
from libqtile import layout, bar, widget
import subprocess
import os

# Startup Scripts
def execute_once(process):
    return subprocess.Popen(process.split())

@hook.subscribe.startup
def startup():
    #  execute_once('compton -CGb')
    execute_once('nm-applet')
    #  execute_once('light-locker')
    execute_once('/usr/bin/blueman-applet')
    home = os.path.expanduser('~/.config/qtile/start.sh')
    subprocess.call([home])

mod = "mod1"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Left", lazy.layout.left()),

    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),

    # Swap panes of split stack
    Key([mod, "shift"], "r", lazy.layout.rotate()),

    Key([mod], "t", lazy.spawn("terminator")),

    # Toggle between different layouts as defined below
    Key([mod], "Return", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),

    # Misc keybindings
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "e", lazy.shutdown()),
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod, "control"], "r", lazy.spawncmd()),
    Key([mod], "d", lazy.spawn("rofi -show run")),
    Key([mod], "n", lazy.spawn("chromium")),
    Key([mod], "b", lazy.spawn("nautilus")),
    #  Key([mod], "p", lazy.spawn("maim -usko | xclip -selection clipboard -t image/png")),
    Key([mod], "l", lazy.spawn("i3lock")),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set 'Master' 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set 'Master' 5%+")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set 'Master' toggle")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),   
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
    Key([], "Print", lazy.spawn("import png:- | xclip -selection clipboard -t image/png")),
    #Key(["control"], "Print", lazy.spawn("import png:- | xclip -selection clipboard -t image/png")),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.Bsp(margin=15, fair=False, border_focus='#FFB400', border_width=4),
    layout.Matrix(border_focus='#FFB400', margin=15, border_width=4),
    layout.MonadTall(border_focus='#FFB400', margin=15, border_width=4),
    layout.Wmii(border_focus='#FFB400', margin=15, border_width=4),
]

widget_defaults = dict(
    font='DejaVuSansMonoForPowerline Nerd Font',
    fontsize=13,
    padding=3,
)
default_configuration1 = dict(
    fontsize=13,
    foreground="FFFFFF",
    background=["071E3A", "071E3A"],
    font="ttf-droid",
    margin_y=2,
    font_shadow="000000",
)
default_configuration2 = dict(
    fontsize=13,
    foreground="FFFFFF",
    background=["071E3A", "071E3A"], 
    font="ttf-droid",
    margin_y=2,
    font_shadow="000000",
)
default_configuration3 = dict(
    fontsize=15,
    foreground="FFFFFF",
    background=["071E3A", "071E3A"], 
    font="ttf-droid",
    margin_y=2,
    font_shadow="000000",
)
default_configuration4 = dict(
    fontsize=15,
    foreground="FFFFFF",
    background=["071E3A", "071E3A"], 
    font="Fantasque Sans Mono Regular Nerd Font Complete Mono",
    margin_y=2,
    font_shadow="000000",
)
group_configuration = dict(
    active="FFFFFF",
    inactive="4E5455",
    fontsize=13,
    background=["071E3A", "071E3A"], 
    font="ttf-droid",
    margin_y=2,
    font_shadow="000000")

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(**group_configuration),
                widget.WindowName(**default_configuration3),
                widget.TextBox(text=" ", **default_configuration1),
                widget.CurrentLayoutIcon(**default_configuration1),
                widget.TextBox(text=" ", **default_configuration1),
                widget.TextBox(text="CPU", **default_configuration1),
                widget.CPUGraph(core="all", frequency=5, line_width=2, border_width=1, background=["071E3A", "071E3A"], graph_color="FFB400"),
                widget.ThermalSensor(tag_sensor="Package id 0", threshold=75, **default_configuration1),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="MEM", **default_configuration1),
                widget.Memory(fmt="{MemUsed}M", update_interval=10, background=["071E3A", "071E3A"]),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="BAT", **default_configuration1),
                widget.Battery(battery_name="BAT1", charge_char="▲", discharge_char="▼", format="{percent:2.0%} {char}", background=["071E3A", "071E3A"], power_now_file="current_now", energy_now_file="charge_now"),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="VOL", **default_configuration1),
                widget.Volume(channel="Master", background=["071E3A", "071E3A"]),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="SCREEN", **default_configuration1),
                widget.Backlight(background=["071E3A", "071E3A"], backlight_name="intel_backlight"),
                widget.TextBox(text="|", **default_configuration1),
                widget.CheckUpdates(**default_configuration1),
                widget.TextBox(text="|", **default_configuration1),
                widget.Systray(**default_configuration1),
                widget.TextBox(text="|", **default_configuration1),
                widget.Clock(**default_configuration4, format='%a, %d/%m/%Y - %H:%M:%S'),
            ],
            22,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(**group_configuration),
                widget.WindowName(**default_configuration3),
                widget.IdleRPG(**default_configuration4),
                widget.CurrentLayoutIcon(**default_configuration1),
                widget.TextBox(text=" ", **default_configuration1),
                widget.TextBox(text="CPU", **default_configuration1),
                widget.CPUGraph(core="all", frequency=5, line_width=2, border_width=1, background=["33393B", "232729"], color="08B2E3"),
                widget.ThermalSensor(tag_sensor="Package id 0", threshold=75, **default_configuration1),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="MEM", **default_configuration1),
                widget.Memory(fmt="{MemUsed}M", update_interval=10, background=["33393B", "232729"]),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="BAT", **default_configuration1),
                widget.Battery(battery_name="BAT1", charge_char="▲", discharge_char="▼", format="{percent:2.0%} {char}", background=["33393B", "232729"]),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="VOL", **default_configuration1),
                widget.Volume(channel="Master", background=["33393B", "232729"]),
                widget.TextBox(text="|", **default_configuration1),
                widget.TextBox(text="SCREEN", **default_configuration1),
                widget.Backlight(background=["33393B", "232729"], backlight_name="intel_backlight"),
                widget.TextBox(text="|", **default_configuration1),
                widget.CheckUpdates(**default_configuration1),
                widget.TextBox(text="|", **default_configuration1),
                widget.Systray(**default_configuration1),
                widget.TextBox(text="|", **default_configuration1),
                widget.Clock(**default_configuration4, format='%a, %d/%m/%Y - %H:%M:%S'),
            ],
            22,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = True
cursor_warp = True
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
#  auto_fullscreen = True
focus_on_window_activation = "smart"

wmname = "Qtile"
