-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local battery_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local volume_widget = require("awesome-wm-widgets.volumebar-widget.volumebar")
local brightness_widget = require("awesome-wm-widgets.brightnessbar-widget.brightnessbar")
local updates_widget = require("awesome-wm-widgets.updates-widget.updates")
local os = require("os")



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart

-- Configure touchpad
awful.spawn("xinput --set-prop \"ELAN0501:01 04F3:3060 Touchpad\" \"libinput Tapping Enabled\" 1")
awful.spawn("xinput --set-prop \"ELAN0501:01 04F3:3060 Touchpad\" \"libinput Natural Scrolling Enabled\" 1")
awful.spawn("xinput --set-prop \"ELAN0501:01 04F3:3060 Touchpad\" \"libinput Accel Speed\" 0.3")

-- Launch Network Manager
awful.spawn("connman-gtk --class='connman-gtk'")

awful.spawn("compton -b")
-- }}}


-- {{{ Variable definitions

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/brunobbs/.config/awesome/theme.lua")

-- This counter allows to filter out miss-clicks of dangerous key cobinations
-- (close awesome, power off, etc)
confirm_count = {}

-- If the system is in resize mode
resize = false

icon_folder = "/home/brunobbs/.config/awesome/icons/"

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Define Volume and Brightness commands
brt_up = "light -A 5"
brt_dn = "light -U 5"
vol_up = "amixer -q set 'Master' 5%+"
vol_dn = "amixer -q set 'Master' 5%-"
vol_mt = "amixer -q set 'Master' toggle"


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget{
    font = "fantasque 12",
    widget = wibox.widget.textclock
}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[9])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
    s.mytaglist.font = "fantasque 12"

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Create help widgets
    local sep = wibox.widget.textbox()
    sep:set_text("   ")

    local tray =  wibox.widget.systray()
    tray:set_base_size(22)

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            sep,
            mylauncher,
            sep,
            s.mytaglist,
            sep,
            s.mypromptbox,
            sep,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            sep,
            updates_widget,
            sep,
            brightness_widget,
            sep,
            vol,
            volume_widget,
            sep,
            battery_widget,
            sep,
            tray,
            sep,
            mytextclock,
            sep,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),


    -- Fn Keys
    awful.key({}, "XF86AudioRaiseVolume", function () awful.spawn(vol_up) end,
        {description = "Raise Volume", group = "client"}),
    awful.key({}, "XF86AudioLowerVolume", function () awful.spawn(vol_dn) end,
        {description = "Lower volume", group = "client"}),
    awful.key({}, "XF86AudioMute", function () awful.spawn(vol_mt) end,
        {description = "Mute Volume", group = "client"}),
    awful.key({}, "XF86MonBrightnessUp", function () awful.spawn(brt_up) end,
        {description = "Raise Brightness", group = "client"}),
    awful.key({}, "XF86MonBrightnessDown", function () awful.spawn(brt_dn) end,
        {description = "Lower Brightness", group = "client"}),

    -- Window focus manipulation
    awful.key({ modkey,           }, "Left", function () awful.client.focus.bydirection("left") end,
        {description = "focus next by direction", group = "client"}),
    awful.key({ modkey,           }, "Right", function () awful.client.focus.bydirection("right") end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey,           }, "Up", function () awful.client.focus.bydirection("up") end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey,           }, "Down", function () awful.client.focus.bydirection("down") end,
        {description = "focus previous by index", group = "client"}),

    -- Window manipulation
    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.bydirection("left") end,
        {description = "focus next by direction", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.bydirection("right") end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Up", function () awful.client.swap.bydirection("up") end,
        {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Down", function () awful.client.swap.bydirection("down") end,
        {description = "focus previous by index", group = "client"}),

    -- Window resizing


    -- Standard programs
    awful.key({ modkey,           }, "t", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "n", function () awful.spawn("chromium") end,
              {description = "open Chromium", group = "launcher"}),
    awful.key({ modkey,           }, "d", function () awful.spawn("rofi -show run") end,
              {description = "open rofi", group = "launcher"}),
    awful.key({ modkey,           }, "b", function () awful.spawn("nautilus") end,
              {description = "open file manager", group = "launcher"}),

    -- Dangerous actions
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "e",
    function()
        if confirm_check(0, "logout.", "Logoff.png") then awesome.quit() end
    end,
              {description = "quit awesome.", group = "awesome"}),
    awful.key({}, "XF86PowerOff",
    function()
        if confirm_check(1, "power off", "Power Off.png") then awful.spawn("shutdown -P 0") end
    end,

              {description = "shutdown computer", group = "awesome"}),

    -- Util keys
    awful.key({}, "Print", function() awful.spawn.with_shell("import png:- | xclip -selection clipboard -t image/png") end,
              {description = "Take a screenshot", group = "awesome"}),

    -- Lock Keys
    awful.key({}, "Caps_Lock",
    function()
        lock_keys_check()
        popup_lock("Caps Lock", lock_keys["Caps Lock"])
    end,
    {description = "Toggle Caps lock indicator", group = "Locks"}
    ),
    awful.key({}, "Num_Lock",
    function()
        lock_keys_check()
        popup_lock("Num Lock", lock_keys["Num Lock"])
    end,
    {description = "Toggle Num lock indicator", group = "Locks"}
    ),
    awful.key({}, "Scroll_Lock",
    function()
        lock_keys_check()
        popup_lock("Scroll Lock", lock_keys["Scroll Lock"])
    end,
    {description = "Toggle Scroll lock indicator", group = "Locks"}
    ),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "m",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),


    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"})
    -- awful.key({ modkey,           }, "m",
    --     function (c)
    --         c.maximized = not c.maximized
    --         c:raise()
    --     end ,
    --     {description = "(un)maximize", group = "client"}),
    -- awful.key({ modkey, "Control" }, "m",
    --     function (c)
    --         c.maximized_vertical = not c.maximized_vertical
    --         c:raise()
    --     end ,
    --     {description = "(un)maximize vertically", group = "client"}),
    -- awful.key({ modkey, "Shift"   }, "m",
    --     function (c)
    --         c.maximized_horizontal = not c.maximized_horizontal
    --         c:raise()
    --     end ,
    --     {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "connman-gtk",
          "xtightvncviewer"
        },

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      },
      properties = {
          floating = true,
          placement = awful.placement.centered
      }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- TODO: this does not work as intended
    -- Disable titlebars if only one wndow in tag
    local tag = c.first_tag

    if #tag:clients() == 1 then c.titlebars_enabled = false end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awesome.connect_signal("list", function(a)
    -- awful.spawn("xrandr --output HDMI-1 --auto --same-as eDP-1 --output eDP-1 --auto")
    naughty.notify{
        text = "Display list changed"
    }
    end
)
-- }}}

-- {{{ Lock keys popup
lock_keys = {
    names = {"Caps Lock", "Num Lock", "Scroll Lock"}
}

function lock_keys_check()
    for i, key_name in ipairs(lock_keys.names) do
        awful.spawn.with_line_callback(
        "bash -c 'sleep 0.2 && xset q'",
        {
            stdout = function (line)
                if line:match(key_name) then
                    local status = line:gsub(".*(" .. key_name .. ":%s+)(%a+).*", "%2")
                    if status == "on" then
                    lock_keys[key_name] = true
                    else
                    lock_keys[key_name] = false
                    end
                end
            end
        }
        )
    end
    -- wibox.wiget:emit_signal("Lock_Keys::Updated")
end

local last_notif = nil
function popup_lock(key, state)
    local info = ""
    -- This value is before the key was pressed
    if state == true then
       info = "OFF"
    else
       info = "ON"
    end
    if last_notif then
        naughty.destroy(last_notif)
        last_notif = nil
    end
    last_notif = naughty.notify(
        {
        title = info,
        text = "",
        icon = icon_folder .. key .. ".png",
        icon_size = 64,
        timeout = 1,
        position = "bottom_middle",
        font = "Sans 20",
        }
    )
end

-- Initialize lock keys status
lock_keys_check()


-- Number of seconds to wait a confirmation
local check_timeout = 1
function confirm_check(id, intent, icon)
    if confirm_count[id] then
        if os.time() - confirm_count[id].last >= check_timeout then
            naughty.notify{
                title = "Press again to confirm " .. intent,
                position = "bottom_middle",
                font = "Sans 15",
                icon_size = 64,
                timeout = check_timeout,
                icon = icon_folder .. icon
            }
            confirm_count[id].last = os.time()
            return false
        else
            return true
        end
    else
        naughty.notify{
            title = "Press again to confirm " .. intent,
            position = "bottom_middle",
            font = "Sans 15",
            icon_size = 64,
            timeout = check_timeout,
            icon = icon_folder .. icon
        }
        confirm_count[id] = {last = os.time()}
        return false
    end
end

-- }}}