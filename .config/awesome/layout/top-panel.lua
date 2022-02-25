--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  Top Left Panel

local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local spotifyWidget = require('widget.spotify-widget')
local cpuWidget = require('widget.cpu-meter')
local gpuWidget = require('widget.gpu-meter')
local ramWidget = require('widget.ram-meter')
local batteryWidget = require('widget.battery')
local timeWidget = require('widget.time')
local dateWidget = require('widget.date')
local volumeWidget = require('widget.volume-slider')
local clickable_container = require('widget.clickable-container')
local gears = require('gears')
local shape = require("gears.shape")
local dpi = require('beautiful').xresources.apply_dpi

local TopPanel = function(s)
    local panel = wibox({
        ontop = false,
        visible = true,
        screen = s,
        height = dpi(32),
        width = "750",
        -- x = s.geometry.x + s.geometry.width / 2 - 750 / 2,
        x = s.geometry.x + beautiful.useless_gap * 2,
        y = s.geometry.y + beautiful.useless_gap * 2,
        stretch = true,
        bg = beautiful.bg_normal .. "00",
        fg = beautiful.fg_normal
    })

    panel:struts({
        top = dpi(32) + beautiful.useless_gap * 2
    })

    local full_rounded_rectangle = function(cr, width, height)
        shape.partially_rounded_rect(cr, width, height, true, true, true, true, dpi(14))
    end

    local resourcesInfo = wibox.widget {
        nil,
        wibox.widget {
            nil,
            wibox.widget {
                nil,
                wibox.widget {
                    nil,
                    wibox.widget {
                        nil,
                        wibox.widget {
                            nil,
                            nil,
                            dateWidget(beautiful.system_magenta_dark),
                            expand = false,
                            layout = wibox.layout.align.horizontal
                        },
                        timeWidget(beautiful.system_blue_dark),
                        expand = false,
                        layout = wibox.layout.align.horizontal
                    },
                    cpuWidget(beautiful.system_green_dark),
                    expand = false,
                    layout = wibox.layout.align.horizontal
                },
                ramWidget(beautiful.system_yellow_dark),
                expand = false,
                layout = wibox.layout.align.horizontal
            },
            gpuWidget(beautiful.system_red_dark),
            expand = false,
            layout = wibox.layout.align.horizontal
        },
        batteryWidget(beautiful.system_cyan_dark),
        expand = false,
        layout = wibox.layout.align.horizontal
    }

    local widget_dashboard_button = wibox.widget {
        {
            markup = "<span color='" .. beautiful.system_white_dark .. "'></span>",
            align = 'center',
            valign = 'center',
            font = 'icomoon 17',
            widget = wibox.widget.textbox
        },
        widget = clickable_container
    }

    widget_dashboard_button:buttons(
    gears.table.join(
    awful.button({}, 1, nil, function()
        local focused = awful.screen.focused()

        local dashboard = focused.dashboard_panel
        dashboard.visible = true
    end)
    )
    )

    local distribution = wibox.widget {
        {
            widget_dashboard_button,
            bg = "#282828",
            -- bg = "#00ff00",
            widget = wibox.container.background
        },
        {
            resourcesInfo,
            left = 15,
            widget = wibox.container.margin
        },
        layout = wibox.layout.ratio.horizontal
    }
    distribution:ajust_ratio(2, 0.04, 0.96, 0.0)

    local mainLayer = wibox.widget {
        wibox.widget {
            distribution,
            left = 20,
            right = 5,
            top = 2,
            bottom = 2,
            widget = wibox.container.margin
        },
        bg = beautiful.bg_normal,
        forced_width = 510,
        forced_height = dpi(32),
        shape = full_rounded_rectangle,
        widget = wibox.container.background
    }

    local backgroundLayer = wibox.widget {
        wibox.widget {
            spotifyWidget({
                dim_when_paused = true,
                dim_opacity = 0.5,
                max_length = -1,
                show_tooltip = false
            }),
            left = 90 + 30,
            right = 20,
            top = 2,
            bottom = 2,
            widget = wibox.container.margin
        },
        bg = beautiful.system_magenta_dark,
        forced_width = 350,
        forced_height = dpi(32),
        shape = full_rounded_rectangle,
        widget = wibox.container.background
    }

    local test3 = wibox.widget {
        wibox.widget {
            backgroundLayer,
            left = 400,
            widget = wibox.container.margin
        },
        mainLayer,
        layout = wibox.layout.manual,
    }

    panel:setup {
        layout = wibox.layout.align.horizontal,
        test3
    }

    return panel
end

return TopPanel
