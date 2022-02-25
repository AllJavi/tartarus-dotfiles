local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TagList = require('widget.tag-list')
local TitleBar = require('widget.focustitle')
local NetworkWidget = require('widget.network')
local VolumeWidget = require('widget.volume')
local KeyboardWidget = require('widget.keyboard-layout')
local gears = require('gears')
local shape = require("gears.shape")
local dpi = require('beautiful').xresources.apply_dpi

local TopPanelSecundary = function(s, offset)
    local panel = wibox({
        ontop = false,
        visible = true,
        screen = s,
        height = dpi(32),
        width = "850",
        -- x = s.geometry.x + s.geometry.width / 2 - 750 / 2,
        x = s.geometry.width - (-s.geometry.x + beautiful.useless_gap * 2 + 850),
        y = s.geometry.y + beautiful.useless_gap * 2,
        stretch = true,
        bg = beautiful.bg_normal .. "00",
        fg = beautiful.fg_normal,
    })

    panel:struts({ top = dpi(32) + beautiful.useless_gap * 2 })

    local full_rounded_rectangle = function(cr, width, height)
        shape.partially_rounded_rect(cr, width, height, true, true, true, true, dpi(14))
    end

    local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
    )


    distribution = wibox.widget {
 {
  {
   TagList(s),
   -- bg = "#00ff00",
   widget = wibox.container.background
  },
  right = 15,
  widget = wibox.container.margin
 },
 {
  {
   TitleBar(s),
   -- bg = "#ff0000",
   widget = wibox.container.background
  },
  left = 5,
  right = 15,
  widget = wibox.container.margin
 },
 {
  {
   NetworkWidget(),
   VolumeWidget,
   KeyboardWidget,
   layout = wibox.layout.ratio.horizontal
  },
  -- bg = "#0000ff",
  widget = wibox.container.background
 },
 layout = wibox.layout.ratio.horizontal
    }
    distribution:ajust_ratio(2, 0.31, 0.57, 0.12)

    mainLayer = wibox.widget {
     wibox.widget {
      distribution,
      left = 20,
      right = 16,
      top = 2,
      bottom = 2,
      widget = wibox.container.margin
     },
     bg = beautiful.bg_normal,
     forced_width = 850,
     forced_height = dpi(32),
     shape = full_rounded_rectangle,
     widget = wibox.container.background

    }

    panel:setup {
     layout = wibox.layout.align.horizontal,
     mainLayer
    }

    return panel
end

return TopPanelSecundary
