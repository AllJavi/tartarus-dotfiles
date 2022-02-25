--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  TaskList Panel

local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local gears = require('gears')
local shape = require("gears.shape")
local dpi = require('beautiful').xresources.apply_dpi

local TasklistPanel = function(s, offset)
    offsety = dpi(7.5)

    local full_rounded_rectangle = function(cr, width, height)
    	shape.partially_rounded_rect(cr, width, height, true, true, true, true, dpi(16))
    end

    local layoutbox = awful.widget.layoutbox(s)

    local panel = wibox({
        ontop = false,
	    visible = true,
        screen = s,
        height = dpi(32),
        width = "750",
        x = s.geometry.x + s.geometry.width / 2 - 750 / 2,
        y = s.geometry.height - (s.geometry.y + beautiful.useless_gap * 2 + dpi(32)),
        stretch = true,
        bg = beautiful.bg_normal .. "dd",
        fg = beautiful.fg_normal,
	    shape = full_rounded_rectangle,
    })

    panel:struts({
	    bottom = dpi(32) + beautiful.useless_gap * 2
    })

    panel:setup{
	    wibox.widget {
            TaskList(s),
            left = 20,
            right = 20,
            widget = wibox.container.margin
	    },
        wibox.widget {
            nil,
            nil,
            wibox.widget {
                layoutbox,
                right = 20,
                top = 5,
                bottom = 5,
                widget = wibox.container.margin
            },
            widget = wibox.layout.align.horizontal
        },
	    layout = wibox.layout.align.horizontal,
    }

    return panel
end

return TasklistPanel
