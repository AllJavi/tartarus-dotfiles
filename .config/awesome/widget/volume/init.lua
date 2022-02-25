--      _    _ _     _             _ 
--     / \  | | |   | | __ ___   _(_)
--    / _ \ | | |_  | |/ _` \ \ / / |
--   / ___ \| | | |_| | (_| |\ V /| |
--  /_/   \_\_|_|\___/ \__,_| \_/ |_|
--
--  github: @AllJavi
--
--  Volume widget

local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')
local beautiful = require('beautiful')
local spawn = awful.spawn
local dpi = beautiful.xresources.apply_dpi
local icons = require('theme.icons')
local apps = require('configuration.apps')
local clickable_container = require('widget.clickable-container')

local icon2 = wibox.widget {
	layout = wibox.layout.align.vertical,
	-- expand = 'none',
	nil,
	{
		image = icons.volume,
		resize = true,
		widget = wibox.widget.imagebox
	},
	nil
}

local icon = wibox.widget {
	font = "JetBrains Mono Regular Nerd Font Complete 14",
	markup = "<span color='".. beautiful.system_yellow_dark .."'>-</span>",
	valign = 'center',
	align = 'center',
	widget = wibox.widget.textbox
}

local action_level = wibox.widget {
	{
		icon,
		widget = clickable_container,
	},
	bg = beautiful.transparent,
	-- shape = gears.shape.circle,
	widget = wibox.container.background
}

local update_slider = function()
	awful.spawn.easy_async_with_shell(
		[[bash -c "amixer -D pulse sget Master"]],
		function(stdout)
			local volume = string.match(stdout, '(%d?%d?%d)%%')
			local volumeNumber = tonumber(volume)
			if volumeNumber > 75 then
				icon:set_markup_silently("<span color='".. beautiful.system_yellow_dark .."'></span>")
			elseif volumeNumber > 30 then
				icon:set_markup_silently("<span color='".. beautiful.system_yellow_dark .."'></span>")
			else
				icon:set_markup_silently("<span color='".. beautiful.system_yellow_dark .."'></span>")
			end
		end
	)
end

-- Update on startup
update_slider()

action_level:buttons(
	awful.util.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				 awesome.emit_signal('module::volume_osd:toogle', true)
			end
		),
		awful.button(
			{},
			3,
			nil,
			function()
				awful.spawn(apps.default.volume_manager,false)
			end
		)
	)
)

-- The emit will come from the global keybind
awesome.connect_signal(
	'widget::volume',
	function()
		update_slider()
	end
)

-- The emit will come from the OSD
awesome.connect_signal(
	'widget::volume:update',
	function(value)
		-- volume_slider:set_value(tonumber(value))
		update_slider()
	end
)

local volume_setting = wibox.widget {
	action_level,
	-- top = dpi(12),
	-- bottom = dpi(12),
	widget = wibox.container.margin
}

return volume_setting
