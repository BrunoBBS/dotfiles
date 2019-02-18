-------------------------------------------------
-- Brightness Bar Widget for Awesome Window Manager
-- Shows the current volume level

-- @author Bruno Scholl
-------------------------------------------------

local awful = require("awful")
local gears = require("gears")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local GET_BRIGHTNESS_CMD = "light -G"   -- "xbacklight -get"
local INC_BRIGHTNESS_CMD = "light -A 1" -- "xbacklight -inc 5"
local DEC_BRIGHTNESS_CMD = "light -U 1" -- "xbacklight -dec 5"

local bar_color = "#EDAE49"
local background_color = "#DCDCCC"


local brightnessbar_widget = wibox.widget {
    max_value = 1,
    forced_width = 100,
    paddings = 0,
    border_width = 0.5,
    color = bar_color,
    background_color = background_color,
    shape = gears.shape.bar,
    clip = true,
    margins       = {
        top = 8.5,
        bottom = 8.5,
    },
    widget = wibox.widget.progressbar
}

local update_graphic = function(widget, stdout, _, _, _)
    local brightness_level = tonumber(string.format("%.0f", stdout))

    widget.value = brightness_level / 100;
end

brightnessbar_widget:connect_signal("button::press", function(_,_,_,button)
    if (button == 4)     then spawn(INC_BRIGHTNESS_CMD, false)
    elseif (button == 5) then spawn(DEC_BRIGHTNESS_CMD, false)
    end

    spawn.easy_async(GET_BRIGHTNESS_CMD, function(stdout, stderr, exitreason, exitcode)
        update_graphic(brightnessbar_widget, stdout, stderr, exitreason, exitcode)
    end)
end)

watch(GET_BRIGHTNESS_CMD, 1, update_graphic, brightnessbar_widget)

return brightnessbar_widget