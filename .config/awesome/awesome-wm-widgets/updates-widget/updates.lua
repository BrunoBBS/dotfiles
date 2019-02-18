local awful = require("awful")
local gears = require("gears")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local command = 'bash -c "yay -Qu | wc -l"'

local updates_widget = wibox.widget{ 
    font = "fantasque 12",
    widget = wibox.widget.textbox
}

local update_text = function(widget, stdout, _, _, _)
    widget.text = stdout
end

watch(command, 60, update_text, updates_widget)

return	updates_widget